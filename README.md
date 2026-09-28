# BGF_navigation_0928 — 1109 이전 주행 버전

**기준 시점:** 2026-09-28, 사용자가 주행이 잘 된다고 확인한 뒤 `ExactGoalSmacPlanner`와
MPPI 조기 yaw 정렬을 추가하기 **직전**. 이번 이후의 전진 이동/조향 허용오차 개선도 포함하지 않는다.
기존 ROBOTIS 소스는 라이선스와 함께 보존했다. [원본 설명](docs/UPSTREAM_README.md).

## 보존한 범위

- 전체 upstream ROS 패키지 트리(기준 commit은 `deployment/manifest.json`).
- SH5 bringup, 실제 base_link 형상/TF 관련 description, 1109 base deadband 0.005.
- Nav2 MPPI 설정, 수정된 IfThenElse BT, 라이다 50–310° 및 average filter 비활성화.
- `bgf_0923_3` 지도, 예제 임무 `missions/0923_1.json`.
- 원본 ROBOTIS MPPI 프리셋 `navigation_mppi_robotis_official.yaml`.
- 이전 구동 바이너리를 재현하기 위한 고정 Docker 이미지 digest와 배포 도구.
- 전체 설정 목록: **[docs/PARAMETERS.md](docs/PARAMETERS.md)**.

실시간 로그, 토큰/인증정보, 데이터셋, 다른 로봇의 작업 중 수정 및 실행에 필요 없는 upstream CI workflow/패치 모음은 업로드 범위에 포함하지 않았다.
Mission Canvas 웹앱 자체는 별도 프로젝트 `cyclo_intelligence`에 있다. 기존 Canvas에서 사용하는
Nav2 실행 경로와 ROS action 인터페이스는 이 저장소로 재현한다. 아래 독립 실행은 RViz로 goal을 보낼 수 있다.

## 버전을 재현할 때 중요한 점

1109는 2026-05-15 빌드의 **설치된 swerve drive-controller**로 주행했다.
현재 upstream 소스와 바이너리의 세부 로직/기본값이 다르므로, 단순히 모든 패키지를 다시 빌드하면
동일 동작을 보장할 수 없다. 제공 Dockerfile은 당시 이미지 digest를 고정하고
**ffw_description, ffw_bringup, ffw_navigation 및 누락된 bringup 의존성 두 개**만 다시 빌드한다.
의존성은 ffw_robot_state_publisher / robotis_hand_pressure_broadcaster이다.
`ffw_swerve_drive_controller`를 통째로 재빌드하지 않는다.

전제: 같은 SH5 하드웨어/모터 ID/조향 영점, `/dev/follower` udev 설정,
라이다 IP 192.168.6.3 및 192.168.6.4, 작동하는 `zenoh_daemon`, Docker Compose v2.
`bgf_0923_3`는 같은 물리 장소에서만 사용할 수 있다. 다른 장소에서는 새 지도와 초기 위치를 지정한다.

## 다른 AI Worker에서 독립 실행

```bash
git clone https://github.com/YWhero/BGF_navigation_0928.git
cd BGF_navigation_0928
./deployment/run.sh
```

비공개 저장소이므로 먼저 GitHub 인증이 필요하다. 실행 스크립트는 기존 `ai_worker`가 켜져 있으면
중복 모터 제어를 막기 위해 종료한다. 해당 로봇의 기존 bringup을 종료한 뒤 실행한다.
`zenoh_daemon`은 계속 실행되어 있어야 한다. 스크립트는 nav/base를 시작하며 이동 목표는 보내지 않는다.

이 최소 실행 경로는 navigation에 불필요한 카메라, 팔/손 시작 자세 이동을 생략한다.
Nav2, 베이스, 라이다 파라미터는 보존한 이전 값이다. 카메라까지 동일한 CPU 부하를 재현하려면
`deployment/start.sh`의 `launch_cameras`를 true로 하고 해당 로봇의 카메라 설정/리소스를 제공한다.

RViz를 사용하는 터미널:

```bash
docker exec -it bgf_navigation_0928 bash -lc \
  'source /opt/ros/jazzy/setup.bash; source /root/ros2_ws/install/setup.bash; export ROS_DOMAIN_ID=30 RMW_IMPLEMENTATION=rmw_zenoh_cpp; rviz2 -d /root/ros2_ws/src/ai_worker/ffw_navigation/rviz/navigation.rviz'
```

호스트의 X display 접근이 구성되어 있어야 한다. **2D Pose Estimate로 현재 위치를 맞추고**
Nav2 Goal을 보낸다. 예제 경로는 Waypoint 2 → Waypoint 1 → Waypoint 2다.
다른 지도는 `MAP_NAME=이름 ./deployment/run.sh`로 지정하며, 해당 yaml/pgm을 maps에 넣고 다시 빌드한다.

종료:

```bash
docker compose -f deployment/compose.yaml down
```

## 기존 Mission Canvas를 사용하는 AI Worker

Canvas의 Run을 중지하고 기존 `ai_worker` bringup/navigation을 종료한 상태에서 작업한다.
현재 ai_worker 소스 디렉터리를 백업하고, 이 저장소를 기존 compose의
`/root/ros2_ws/src/ai_worker` bind mount 경로로 연결한다.

기존 container가 manifest의 바이너리 버전과 같은 경우 다음 패키지만 빌드한다.

```bash
docker exec ai_worker bash -lc \
  'source /opt/ros/jazzy/setup.bash; source /root/ros2_ws/install/setup.bash; cd /root/ros2_ws; colcon build --packages-select ffw_description ffw_robot_state_publisher robotis_hand_pressure_broadcaster ffw_bringup ffw_navigation --symlink-install --cmake-args -DBUILD_TESTING=OFF'
```

베이스 bringup도 재시작해야 deadband/라이다 설정을 읽는다. 이후 Canvas에서 지도를 선택해
navigation runtime을 다시 시작한다. `navigation.launch.py`의 기본 params_file은
이 저장소의 `navigation_mppi_1109.yaml`이다. `docker/s6-services/ai_worker_navigation` 서비스가
기존 이미지에 없으면 이 저장소의 `docker/Dockerfile.navigation-local` 절차로 서비스를 설치해야 한다.
Canvas와 예제 mission 파일 형식은 별도 프로젝트에 속하므로 이 저장소 clone만으로 웹앱이 설치되지는 않는다.

## 기준 설정 요약과 알려진 한계

| 구분 | 이전 값 |
|---|---|
| MPPI 모델 | OmniController / CurveController 모두 Omni |
| 경로별 선택 | 전체 경로 길이 ≤2 m: Omni, >2 m: Curve; 한 요청 중 고정 |
| MPPI 계산 | 40 steps × 0.05 s, batch 1200; Omni iteration 4 / Curve 1 |
| 속도 | Omni X/Y ±0.35 m/s, yaw ±0.7 rad/s; Curve X 0~0.35, Y ±0.25 |
| 가속도 | X/Y 0.5 m/s², yaw 1.2 rad/s² |
| 목표 정렬 | Omni GoalAngle weight 5 / 0.25 m, Curve 2 / 0.3 m |
| 목표 판정 | 위치 0.025 m, yaw 0.02 rad, stateful=false |
| 진행 판정 | PoseProgressChecker: 0.02 m 또는 0.02 rad / 20 s |
| planner | SmacPlannerHybrid, REEDS_SHEPP, 24 angle bins, tolerance 0 |
| local costmap | odom, 3×3 m, 0.025 m resolution, 10 Hz update / 2 Hz publish |
| local inflation | radius 0.48 m, scaling 10 |
| global costmap | map, 0.05 m resolution, 1 Hz, static+obstacle+inflation |
| global inflation | radius 0.55 m, scaling 5 |
| footprint | SH5 차체+바퀴 회전 외곽 17점, padding 0.02 m |
| smoother | OPEN_LOOP 20 Hz, deadband 0, 속도/가속도 위와 동일 |
| AMCL | OmniMotionModel, 800–2000 particles, 80 beams, update 0.02 m/rad |
| lidar | 좌/우 50–310°, shadow filter 켬, average filter 끔, local inf clearing 켬 |
| base | wheel radius 0.0825 m, linear/angular deadband 0.005 |
| base 조향 출발 조건 | 0.01 rad; 이동 중 조건 1.0 rad |

이전 버전을 정확히 보존하기 때문에 **알려진 yaw 양자화 오차와 엄격한 조향 출발 조건도 존재한다**.
저장된 waypoint yaw가 15° 대표 방향과 다르면 Canvas의 정확한 도착 검증에 실패할 수 있다.
MPPI iteration 4의 계산량, 0.01 rad 출발 조건으로 인한 정렬 지연/정지 가능성도 남아 있다.
이 저장소는 비교/재현용 기준점이며 이후 개선본과 혼동하지 않는다.

튜닝할 때 참고할 값의 역할:

- `vx_max/vx_min/vy_max/wz_max`: 속도 제한. smoother 및 실제 베이스 설정과 함께 맞춘다.
- `ax_max/ay_max/az_max`, `model_dt`: 한 제어 주기의 가속 한도와 예측 간격.
- `batch_size`, `time_steps`, `iteration_count`: 계산량과 탐색 범위. 제어 주기 실측과 함께 조정한다.
- Goal/GoalAngle critic weight/threshold: 목표 위치/각도 비용 및 적용 거리.
- PathAlign/PathFollow/PathAngle/PreferForward: 경로 추종, 전방 지향, 후진 선호 억제.
- `inflation_radius/cost_scaling_factor`: 장애물 주변 비용 영역과 감쇠. 실제 footprint와 구분한다.
- `xy_goal_tolerance/yaw_goal_tolerance`: 완료 조건. Canvas 완료 조건과 일치해야 한다.
- `angle_quantization_bins`: planner 방향 해상도(360°/개수). 최종 yaw 전달에도 영향을 준다.
- `steering_alignment_start_angle_error_threshold`: 정지 상태에서 구동을 허용하는 바퀴 조향 오차.
