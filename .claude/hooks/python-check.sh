#!/bin/bash

ENABLE_RUFF=${ENABLE_RUFF:-true}
ENABLE_TY=${ENABLE_TY:-false}
ENABLE_PYREFLY=${ENABLE_PYREFLY:-false}

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Only process Python files
if [[ ! "$FILE_PATH" =~ \.py$ ]] || [[ ! -f "$FILE_PATH" ]]; then
	exit 0
fi

echo "🔧 Running check for Python files..."

# Run check
CHECK_SUCCESS=true

if [[ "$ENABLE_RUFF" == "true" ]]; then
	echo "🔧 Running ruff check..."
	if ! uvx ruff check . --fix; then
		echo "❌ ruff check failed" >&2
		CHECK_SUCCESS=false
	fi
fi

if [[ "$ENABLE_TY" == "true" ]]; then
	echo "🔧 Running ty check..."
	if ! uvx ty check .; then
		echo "❌ ty check failed" >&2
		CHECK_SUCCESS=false
	fi
fi

if [[ "$ENABLE_PYREFLY" == "true" ]]; then
	echo "🔧 Running pyrefly check..."
	if ! uvx pyrefly check; then
		echo "❌ pyrefly check failed" >&2
		CHECK_SUCCESS=false
	fi
fi

if [[ "$CHECK_SUCCESS" == "true" ]]; then
	echo "✅ All checks passed"
else
	echo "❌ Check failed. Please fix the issues above." >&2
	exit 2
fi

exit 0
