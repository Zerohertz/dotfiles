---
description: "GitHub issue filtering and management tool"
allowed_tools: ["Bash"]
---

# GitHub Issue Filtering

Filter and manage GitHub issues with various criteria.

## Usage

- `/issue [filter]` - Filter issues by criteria (default: open)
- `/issue open` - Show open issues
- `/issue closed` - Show closed issues
- `/issue label [label]` - Filter by label
- `/issue author [username]` - Filter by author
- `/issue assignee [username]` - Filter by assignee
- `/issue milestone [milestone]` - Filter by milestone
- `/issue state [state]` - Filter by state (open/closed)

## Actions to perform

Execute GitHub CLI commands based on the filter type:

**Default (no arguments)**: Show open issues

```bash
gh issue list --state open --limit 20
```

**open**: Show open issues

```bash
gh issue list --state open --limit 20
```

**closed**: Show closed issues

```bash
gh issue list --state closed --limit 20
```

**label**: Filter by specific label

```bash
gh issue list --label "$1" --limit 20
```

**author**: Filter by author

```bash
gh issue list --author "$1" --limit 20
```

**assignee**: Filter by assignee

```bash
gh issue list --assignee "$1" --limit 20
```

**milestone**: Filter by milestone

```bash
gh issue list --milestone "$1" --limit 20
```

**state**: Filter by state

```bash
gh issue list --state "$1" --limit 20
```

**search**: Search issues by text

```bash
gh issue list --search "$1" --limit 20
```

## Examples

- `/issue` - Show open issues
- `/issue label bug` - Show issues with "bug" label
- `/issue author octocat` - Show issues created by octocat
- `/issue assignee @me` - Show issues assigned to you
- `/issue milestone "v1.0"` - Show issues in v1.0 milestone
- `/issue search "memory leak"` - Search for issues containing "memory leak"