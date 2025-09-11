---
description: "Code review and analysis tool"
---

# Code Review and Analysis

Perform code reviews and analyze code quality, security, and best practices.

## Usage

- `/code-review` - Review all staged changes
- `/code-review file [filepath]` - Review specific file
- `/code-review commit [hash]` - Review specific commit
- `/code-review diff` - Review current diff
- `/code-review security` - Security-focused review
- `/code-review performance` - Performance-focused review
- `/code-review style` - Code style review

## Actions to perform

Execute review commands based on the type:

**Default (no arguments)**: Review staged changes

```bash
git diff --cached --name-only | head -10
```

If files are staged, show the diff:

```bash
git diff --cached
```

**file**: Review specific file

```bash
git log -1 --name-only --pretty=format: "$1" 2>/dev/null || echo "File: $1"
```

Then show the file content for review.

**commit**: Review specific commit

```bash
git show "$1" --stat
```

```bash
git show "$1"
```

**diff**: Review current working directory changes

```bash
git diff --name-only | head -10
```

```bash
git diff
```

**security**: Security-focused code review

```bash
grep -r -n -E "(password|secret|key|token)" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" --include="*.rs" | grep -v ".git" | head -10
```

```bash
grep -r -n -E "(eval|exec|system|shell_exec)" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" --include="*.rs" | grep -v ".git" | head -10
```

**performance**: Performance-focused review

```bash
grep -r -n -E "(for.*in|while|map|filter|reduce)" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" --include="*.rs" | grep -v ".git" | head -10
```

**style**: Code style review

```bash
find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.rs" | xargs wc -l | sort -nr | head -10
```

## Examples

- `/code-review` - Review staged changes
- `/code-review file src/main.py` - Review main.py file
- `/code-review commit abc123` - Review commit abc123
- `/code-review security` - Check for security issues
- `/code-review performance` - Look for performance bottlenecks
- `/code-review style` - Check code style and formatting
