---
description: "개발 환경 설정 및 도구 관리"
allowed_tools: ["Bash", "Read", "Grep", "LS"]
---

# 개발 환경 관리

개발 도구와 환경을 설정하고 관리합니다.

## 사용법
- `/dev setup` - 개발 환경 초기 설정
- `/dev update` - 모든 개발 도구 업데이트
- `/dev check` - 개발 도구 상태 확인
- `/dev clean` - 캐시 및 임시 파일 정리

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**setup**: 기본 개발 환경 설정
```bash
!brew update && brew upgrade
!npm update -g
!pip install --upgrade pip
```

**update**: 모든 개발 도구 업데이트
```bash
!brew update && brew upgrade
!npm update -g
!pip list --outdated | grep -v '^\-e' | cut -d ' ' -f1 | xargs -n1 pip install -U
```

**check**: 개발 도구 버전 및 상태 확인
```bash
!node --version && npm --version
!python --version && pip --version
!git --version
!brew --version
!docker --version
```

**clean**: 개발 관련 캐시 정리
```bash
!npm cache clean --force
!pip cache purge
!brew cleanup
!docker system prune -f
```

기본값으로 check를 실행합니다.