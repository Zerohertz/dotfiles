---
description: "파일 검색 및 탐색 도구"
allowed_tools: ["Bash", "Grep", "Glob", "Read"]
---

# 파일 검색 및 탐색

프로젝트 내 파일을 효율적으로 검색하고 탐색합니다.

## 사용법
- `/find code [검색어]` - 코드 내용 검색
- `/find file [파일명]` - 파일명으로 검색
- `/find config` - 설정 파일 찾기
- `/find large` - 큰 파일 찾기

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**code**: 코드 내용에서 검색어 찾기
```bash
!grep -r "$1" . --include="*.js" --include="*.ts" --include="*.py" --include="*.go" --include="*.rs" | head -20
```

**file**: 파일명으로 검색
```bash
!find . -name "*$1*" -type f | head -20
```

**config**: 설정 파일들 찾기
```bash
!find . -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml" -o -name "*.conf" | head -20
```

**large**: 큰 파일들 찾기 (10MB 이상)
```bash
!find . -size +10M -type f -exec ls -lh {} \; | head -10
```

인자가 없으면 현재 디렉토리의 파일 구조를 보여줍니다:
```bash
!tree -L 3 || find . -type d -maxdepth 3 | head -20
```