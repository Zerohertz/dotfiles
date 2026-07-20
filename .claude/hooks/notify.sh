#!/bin/bash

INPUT=$(cat)

EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // empty')

case "$EVENT" in
Stop)
	MESSAGE="Claude has finished responding"
	;;
*)
	MESSAGE=$(echo "$INPUT" | jq -r '.message // "Claude needs your attention"')
	;;
esac

# Short directory name (last 2 segments)
DIR=""
if [[ -n "$CWD" ]]; then
	DIR=$(echo "$CWD" | rev | cut -d'/' -f1-2 | rev)
fi

# Extract last tool call detail from transcript
DETAIL=""
if [[ -n "$TRANSCRIPT" && -f "$TRANSCRIPT" ]]; then
	# Only consider tool_uses after the last user message (i.e., current turn)
	USER_LINE=$(grep -n '"type":"user"' "$TRANSCRIPT" | grep -v '"toolUseResult"' | tail -1 | cut -d: -f1)
	if [[ -n "$USER_LINE" ]]; then
		DETAIL=$(tail -n +$((USER_LINE + 1)) "$TRANSCRIPT" | jq -r --arg cwd "$CWD" '
			select(.type == "assistant") |
			.message.content[]? |
			select(.type == "tool_use") |
			if .name == "Bash" then "$ " + (.input.command // "" | split("\n")[0])
			elif .name == "Edit" or .name == "Write" or .name == "MultiEdit" then .name + ": " + ((.input.file_path // "") | sub("^" + $cwd + "/"; ""))
			elif .name == "Read" then "Read: " + ((.input.file_path // "") | sub("^" + $cwd + "/"; ""))
			else .name
			end
		' 2>/dev/null | tail -1)
	fi
	# Truncate to 60 chars
	if [[ ${#DETAIL} -gt 60 ]]; then
		DETAIL="${DETAIL:0:57}..."
	fi
fi

# Build notification title (include tmux session name if inside tmux)
TITLE="Claude Code"
SESSION=""
if [[ -n "$TMUX" ]]; then
	# -t pins the lookup to this pane's session; without it tmux picks a
	# best-effort "current" session, which can be the wrong one from a hook.
	SESSION=$(tmux display-message -p -t "$TMUX_PANE" '#S' 2>/dev/null)
fi
if [[ -n "$SESSION" && -n "$DIR" ]]; then
	TITLE="Claude Code [$SESSION:$DIR]"
elif [[ -n "$SESSION" ]]; then
	TITLE="Claude Code [$SESSION]"
elif [[ -n "$DIR" ]]; then
	TITLE="Claude Code [$DIR]"
fi

BODY="$MESSAGE"
if [[ -n "$DETAIL" ]]; then
	BODY="$MESSAGE | $DETAIL"
fi

# Strip ESC/BEL so a stray control byte in a tool call cannot truncate or corrupt
# the escape sequence we are about to write.
BODY=$(printf '%s' "$BODY" | tr -d '\033\007')
TITLE=$(printf '%s' "$TITLE" | tr -d '\033\007')

# Hooks run without a controlling terminal, so /dev/tty cannot be opened at all
# (ENXIO) -- but a tty opened by *path* needs no controlling terminal. Resolve
# the terminal emulator's own pty and write the notification straight to it.
notify_terminal() {
	local title="$1"
	local body="$2"
	local seq target session
	local ttys=()

	printf -v seq '\e]777;notify;%s;%s\a' "$title" "$body"

	if [[ -n "$TMUX" ]]; then
		# The attached client's tty is the emulator's pty, so writing there bypasses
		# tmux entirely. DCS passthrough would instead be gated by allow-passthrough,
		# which drops the sequence whenever this pane is not visible -- precisely
		# when the notification matters.
		session=$(tmux display-message -p -t "$TMUX_PANE" '#{session_name}' 2>/dev/null)
		if [[ -n "$session" ]]; then
			while read -r target; do
				[[ -n "$target" ]] && ttys+=("$target")
			done < <(tmux list-clients -F '#{client_tty}' -t "$session" 2>/dev/null)
		fi
	fi

	if [[ ${#ttys[@]} -eq 0 ]]; then
		# Outside tmux, or the lookup failed: fall back to the parent's tty.
		target=$(ps -o tty= -p "$PPID" 2>/dev/null | tr -d '[:space:]')
		[[ -n "$target" && "$target" != "??" ]] && ttys+=("/dev/$target")
	fi

	for target in "${ttys[@]}"; do
		printf '%s' "$seq" >"$target" 2>/dev/null
	done

	if [[ -n "$TMUX" ]]; then
		tmux display-message "$title: $body" 2>/dev/null
	fi
}

notify_terminal "$TITLE" "$BODY"

exit 0
