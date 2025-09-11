---
description: "Code refactoring assistant and analysis tool"
---

# Code Refactoring Assistant

Analyze and refactor code for better maintainability, performance, and readability.

## Usage

- `/refact` - Analyze current file for refactoring opportunities
- `/refact file [filepath]` - Refactor specific file
- `/refact extract [function]` - Extract function/method
- `/refact rename [old] [new]` - Rename variables/functions
- `/refact optimize` - Performance optimization suggestions
- `/refact clean` - Remove dead code and unused imports
- `/refact patterns` - Apply design patterns
- `/refact split` - Split large functions/classes

## Actions to perform

Execute refactoring based on the type:

**Default (no arguments)**: Analyze current directory for refactoring

```bash
find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.rs" | head -10
```

```bash
wc -l $(find . -name "*.js" -o -name "*.ts" -o -name "*.py" | head -5) | sort -nr
```

**file**: Refactor specific file

```bash
wc -l "$1"
```

Then analyze the file for refactoring opportunities.

**extract**: Extract function from code block

```bash
grep -n "function\|def\|func" "$1" | head -10
```

**rename**: Rename variables/functions across files

```bash
grep -r -n "$1" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" | head -10
```

**optimize**: Find performance bottlenecks

```bash
grep -r -n -E "(for.*in|while|map|filter|nested)" . --include="*.js" --include="*.ts" --include="*.py" | head -10
```

**clean**: Find unused code and imports

```bash
grep -r -n -E "(import|require|from.*import)" . --include="*.js" --include="*.ts" --include="*.py" | head -10
```

**patterns**: Suggest design pattern implementations

```bash
grep -r -n -E "(class|interface|extends|implements)" . --include="*.js" --include="*.ts" --include="*.py" | head -10
```

**split**: Identify large functions/classes to split

```bash
awk '/^(function|def|class)/ {start=NR} /^}$|^$/ {if(start && NR-start>50) print FILENAME":"start":"$0; start=0}' $(find . -name "*.js" -o -name "*.py" | head -5)
```

## Examples

- `/refact` - Analyze current codebase for refactoring
- `/refact file src/utils.js` - Refactor utils.js file
- `/refact extract calculateTotal` - Extract calculateTotal function
- `/refact rename oldVar newVar` - Rename variable across project
- `/refact optimize` - Find performance improvement opportunities
- `/refact clean` - Remove dead code and unused imports
- `/refact patterns` - Apply design patterns to improve structure
- `/refact split` - Split large functions into smaller ones
