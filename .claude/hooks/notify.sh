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
	SESSION=$(tmux display-message -p '#S' 2>/dev/null)
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

notify_terminal() {
	local title="$1"
	local body="$2"
	if [[ -n "$TMUX" ]]; then
		# Wrap OSC 777 in tmux passthrough so escape reaches outer terminal
		printf '\ePtmux;\e\e]777;notify;%s;%s\a\e\\' "$title" "$body" >/dev/tty 2>/dev/null
		tmux display-message "$title: $body" 2>/dev/null
	else
		printf '\e]777;notify;%s;%s\a' "$title" "$body" >/dev/tty 2>/dev/null
	fi
}

notify_terminal "$TITLE" "$BODY"

exit 0
