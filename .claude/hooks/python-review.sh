#!/bin/bash

DISABLE_REVIEW=${DISABLE_REVIEW:-0}
CC_REVIEWER=${CC_REVIEWER:-opencode}

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Check if review is disabled
if [[ -n "$DISABLE_REVIEW" ]]; then
	exit 0
fi

# Only review Python files
if [[ ! "$FILE_PATH" =~ \.py$ ]] || [[ ! -f "$FILE_PATH" ]]; then
	exit 0
fi

# Python-specific review prompt
PROMPT="@$FILE_PATH Review this Python code for:
1. Type hints usage and correctness
2. Exception handling
3. PEP 8 compliance
4. Security issues (input validation, etc.)
5. Performance optimizations
6. Proper use of Python idioms
Be concise, only mention important issues."

# Check for environment variable to determine which tool to use
if [[ "$CC_REVIEWER" == "gemini" ]]; then
	COMMAND="gemini -m gemini-2.5-flash -p"
	TOOL_NAME="Gemini"
else
	COMMAND="opencode run -m opencode/grok-code"
	TOOL_NAME="OpenCode"
fi

echo "🔍 Running $TOOL_NAME code review for $FILE_PATH..." >&2
REVIEW_OUTPUT=$($COMMAND "$PROMPT" 2>&1)

# Output review to stderr so Claude can see it
echo "$REVIEW_OUTPUT" >&2
echo "$REVIEW_OUTPUT" >>~/.claude.hooks.python-review.log

# Exit with code 2 so Claude processes the stderr output
exit 2
