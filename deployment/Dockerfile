# Preserve the 2026-05-15 SH5 drive-controller binary used by the working baseline.
FROM robotis/ai-worker@sha256:cb3e246ec73fa1593d9940bae3d38ba6676d6c0419e0ce479b0ba945a26ca5fb
SHELL ["/bin/bash", "-c"]
COPY . /root/ros2_ws/src/ai_worker/
RUN source /opt/ros/jazzy/setup.bash && source /root/ros2_ws/install/setup.bash && \
    cd /root/ros2_ws && \
    colcon build --packages-select ffw_description ffw_robot_state_publisher robotis_hand_pressure_broadcaster ffw_bringup ffw_navigation \
      --symlink-install --cmake-args -DBUILD_TESTING=OFF
ENTRYPOINT ["/bin/bash", "/root/ros2_ws/src/ai_worker/deployment/start.sh"]
