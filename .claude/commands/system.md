---
description: "시스템 모니터링 및 유지보수"
allowed_tools: ["Bash"]
---

# 시스템 관리

macOS 시스템 상태를 모니터링하고 유지보수합니다.

## 사용법
- `/system status` - 시스템 전반적인 상태 확인
- `/system monitor` - 실시간 시스템 모니터링
- `/system clean` - 시스템 정리 및 최적화
- `/system info` - 시스템 정보 출력

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**status**: 시스템 전반 상태 확인
```bash
!df -h
!vm_stat | head -10
!uptime
!who
```

**monitor**: 실시간 시스템 리소스 모니터링
```bash
!top -l 1 -o cpu -n 10
!iostat -c 2 5
!netstat -i
```

**clean**: 시스템 정리 작업
```bash
!sudo periodic daily weekly monthly
!rm -rf ~/.Trash/*
!sudo purge
```

**info**: 상세 시스템 정보
```bash
!system_profiler SPSoftwareDataType
!sysctl -n machdep.cpu.brand_string
!sw_vers
!uname -a
```

기본값으로 status를 실행합니다.