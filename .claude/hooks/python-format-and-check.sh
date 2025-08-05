#!/bin/bash

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Only process Python files
if [[ ! "$FILE_PATH" =~ \.py$ ]] || [[ ! -f "$FILE_PATH" ]]; then
	exit 0
fi

echo "🔧 Running project-specific format and check for Python files..."

# Run format
if uvx ruff format .; then
	echo "✅ Format completed"
else
	echo "❌ Format failed" >&2
	exit 2
fi

# Run check
if uvx ruff check . --fix && uvx ty check . && uvx pyrefly check; then
	echo "✅ All checks passed"
else
	echo "❌ Check failed. Please fix the issues above." >&2
	exit 2
fi

exit 0
