---
description: "Dotfiles 관리 및 설정 동기화 명령어"
allowed_tools: ["Bash", "Read", "LS"]
---

# Dotfiles 관리

dotfiles 저장소의 설정 파일들을 관리하고 동기화합니다.

## 사용법
- `/dotfiles sync` - macOS 설정 동기화
- `/dotfiles sync-linux` - Linux 설정 동기화  
- `/dotfiles check` - 설정 변경사항 확인 (dry-run)
- `/dotfiles status` - Git 상태 확인

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**sync**: macOS 환경으로 모든 dotfiles 동기화
```bash
!make macos
```

**sync-linux**: Linux 환경으로 dotfiles 동기화  
```bash
!make linux
```

**check**: 변경사항을 실제 적용하지 않고 확인
```bash
!make -n macos
```

**status**: 현재 Git 상태와 변경된 파일 확인
```bash
!git status --porcelain
!git diff --name-only
```

기본값으로 sync를 실행합니다.