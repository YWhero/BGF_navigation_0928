#!/usr/bin/env bash
set -eo pipefail
source /opt/ros/jazzy/setup.bash
source /root/ros2_ws/install/setup.bash
export ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-30}"
export RMW_IMPLEMENTATION="${RMW_IMPLEMENTATION:-rmw_zenoh_cpp}"
map_name="${MAP_NAME:-bgf_0923_3}"
[[ "$map_name" =~ ^[A-Za-z0-9_.-]+$ ]] || { echo 'Invalid MAP_NAME' >&2; exit 1; }
root=/root/ros2_ws/src/ai_worker
[[ -e /dev/follower ]] || { echo 'Missing /dev/follower: install the SH5 udev rule first.' >&2; exit 1; }
children=()
finish() {
  trap - EXIT INT TERM
  if ((${#children[@]})); then kill -INT "${children[@]}" 2>/dev/null || true; wait || true; fi
}
trap finish EXIT INT TERM
# A router must already be running on the robot, as on 1109 (zenoh_daemon).
ros2 launch ffw_bringup ffw_sh5_follower_ai.launch.py launch_cameras:=false \
  init_position:=false enable_hand_current:=false &
children+=("$!")
ros2 launch ffw_navigation navigation.launch.py \
  map:="$root/ffw_navigation/maps/$map_name.yaml" rviz:=false &
children+=("$!")
wait -n "${children[@]}"
