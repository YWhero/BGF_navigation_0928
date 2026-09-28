# 배포 검증 (2026-09-28)

- 고정 이미지에서 5개 선택 패키지 Docker build 성공.
- 하드웨어/네트워크에 연결하지 않은 새 container에서 SH5 bringup 및 navigation launch의 `--show-args` 해석 성공.
- Nav2 MPPI/Smac 패키지 버전이 1109 실행 환경과 일치함을 확인.
- 설치된 swerve controller 라이브러리 SHA-256이 1109와 완전히 일치함을 확인.
- 기준 YAML은 직전 수정 전 백업과 byte-for-byte 동일.
- ExactGoalSmacPlanner/장거리 controller 전환 변경이 포함되지 않았음을 확인.
- 다른 물리 로봇의 실주행은 미검증. 로봇별 조향 영점, 모터 연결 및 localization 설정이 필요하다.

환경 세부 값은 `deployment/manifest.json`, 주요 파일 체크섬은 `deployment/SHA256SUMS`에 기록했다.
