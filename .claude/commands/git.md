---
description: "Git 워크플로우 및 저장소 관리"
allowed_tools: ["Bash", "Read"]
---

# Git 워크플로우

Git 저장소 관리 및 일반적인 워크플로우를 자동화합니다.

## 사용법
- `/git status` - 상태 확인 및 요약
- `/git sync` - 변경사항 동기화
- `/git clean` - 정리 작업
- `/git info` - 저장소 정보

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**status**: Git 상태 및 변경사항 요약
```bash
!git status --porcelain
!git log --oneline -10
!git branch -a --sort=-committerdate | head -10
```

**sync**: 현재 브랜치 동기화 (commit + push)
```bash
!git add .
!git commit -m "✨ Auto sync: $(date '+%Y-%m-%d %H:%M')"
!git push
```

**clean**: Git 저장소 정리
```bash
!git clean -fd
!git gc --prune=now
!git remote prune origin
```

**info**: 저장소 및 원격 정보
```bash
!git remote -v
!git log --graph --pretty=format:'%h - %an, %ar : %s' -10
!git shortlog -sn
```

기본값으로 status를 실행합니다.