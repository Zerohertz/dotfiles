---
description: "File search and exploration tool"
allowed_tools: ["Bash", "Grep", "Glob", "Read"]
---

# File Search and Exploration

Efficiently search and explore files within the project.

## Usage

- `/find code [search term]` - Search code content
- `/find file [filename]` - Search by filename
- `/find config` - Find configuration files
- `/find large` - Find large files

## Actions to perform

Execute one of the following based on $ARGUMENTS:

**code**: Search for terms in code content

```bash
!grep -r "$1" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" --include="*.rs" | head -20
```

**file**: Search by filename

```bash
!find . -name "*$1*" -type f | head -20
```

**config**: Find configuration files

```bash
!find . -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml" -o -name "*.conf" | head -20
```

**large**: Find large files (over 10MB)

```bash
!find . -size +10M -type f -exec ls -lh {} \; | head -10
```

If no arguments provided, show current directory structure:

```bash
!tree -L 3 || find . -type d -maxdepth 3 | head -20
```
