---
description: "디버깅 및 문제 해결 도구"
allowed_tools: ["Bash", "Read", "Grep"]
---

# 디버깅 및 문제 해결

시스템 및 애플리케이션 문제를 진단하고 해결합니다.

## 사용법
- `/debug process` - 프로세스 문제 진단
- `/debug network` - 네트워크 연결 문제 확인
- `/debug disk` - 디스크 사용량 및 권한 문제
- `/debug logs` - 시스템 로그 확인

## 실행할 작업
$ARGUMENTS를 기반으로 다음 중 하나를 실행:

**process**: 프로세스 및 메모리 문제 진단
```bash
!ps aux | head -20
!lsof -i | head -10
!netstat -an | grep LISTEN | head -10
```

**network**: 네트워크 연결성 테스트
```bash
!ping -c 3 google.com
!nslookup google.com
!curl -I https://github.com
```

**disk**: 디스크 공간 및 권한 확인
```bash
!df -h
!du -sh * | sort -hr | head -10
!ls -la | head -10
```

**logs**: 시스템 및 애플리케이션 로그 확인
```bash
!tail -20 /var/log/system.log
!dmesg | tail -20
!log show --last 1h --predicate 'eventMessage contains "error"' | head -10
```

기본값으로 process를 실행합니다.