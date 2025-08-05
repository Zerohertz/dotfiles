#!/bin/bash

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Only review Python files
if [[ ! "$FILE_PATH" =~ \.py$ ]] || [[ ! -f "$FILE_PATH" ]]; then
	exit 0
fi

echo "🔍 Running Gemini code review for $FILE_PATH..." >&2

# Python-specific review prompt
REVIEW_OUTPUT=$(gemini -p "@$FILE_PATH" "Review this Python code for:
1. Type hints usage and correctness
2. Exception handling
3. PEP 8 compliance
4. Security issues (input validation, etc.)
5. Performance optimizations
6. Proper use of Python idioms
Be concise, only mention important issues." 2>&1)

# Output review to stderr so Claude can see it
echo "$REVIEW_OUTPUT" >&2

# Exit with code 2 so Claude processes the stderr output
exit 2
