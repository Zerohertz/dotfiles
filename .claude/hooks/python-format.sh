#!/bin/bash

ENABLE_ISORT=${ENABLE_ISORT:-1}
ENABLE_BLACK=${ENABLE_BLACK:-1}
ENABLE_RUFF=${ENABLE_RUFF:-1}

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Only process Python files
if [[ ! "$FILE_PATH" =~ \.py$ ]] || [[ ! -f "$FILE_PATH" ]]; then
	exit 0
fi

echo "🔧 Running format for Python files..."

# Run format
FORMAT_SUCCESS=1

if [[ "$ENABLE_ISORT" -eq 1 ]]; then
	echo "🔧 Running isort..."
	if ! uvx isort .; then
		echo "❌ isort failed" >&2
		FORMAT_SUCCESS=0
	fi
fi

if [[ "$ENABLE_BLACK" -eq 1 ]]; then
	echo "🔧 Running black..."
	if ! uvx black .; then
		echo "❌ black failed" >&2
		FORMAT_SUCCESS=0
	fi
fi

if [[ "$ENABLE_RUFF" -eq 1 ]]; then
	echo "🔧 Running ruff format..."
	if ! uvx ruff format .; then
		echo "❌ ruff format failed" >&2
		FORMAT_SUCCESS=0
	fi
fi

if [[ "$FORMAT_SUCCESS" -eq 1 ]]; then
	echo "✅ Format completed"
else
	echo "❌ Format failed" >&2
	exit 2
fi

exit 0
