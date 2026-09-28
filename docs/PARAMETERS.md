# 이전 버전의 전체 명시 파라미터

기준: ExactGoalSmacPlanner 및 MPPI 조기 정렬 변경 직전. 원본은 `ffw_navigation/config/navigation_mppi_1109.yaml`이다.

이 목록은 파일에 명시된 설정이다. Nav2 전체 기본값 목록과 구분해야 한다. 설치된 Jazzy에서 선언되지 않는 키는 동작에 영향이 없다.

확인된 미지원 키: Hybrid의 `use_final_approach_orientation`. 나머지 키도 runtime 선언 여부는 `ros2 param list /planner_server` 및 `ros2 param list /controller_server`로 확인한다.

지원 모델: MPPI는 DiffDrive / Omni / Ackermann, Hybrid 검색은 DUBIN / REEDS_SHEPP. 이 버전은 두 MPPI 모두 Omni, Hybrid 검색은 REEDS_SHEPP이다.

단위: 거리 m, 선속도 m/s, 각도 rad, 각속도 rad/s, 가속도 m/s² 또는 rad/s², 시간 s.

## bt_navigator

| 파라미터 | 값 |
|---|---|
| `ros__parameters.global_frame` | `"map"` |
| `ros__parameters.robot_base_frame` | `"base_link"` |
| `ros__parameters.odom_topic` | `"/odom"` |
| `ros__parameters.bt_loop_duration` | `10` |
| `ros__parameters.default_server_timeout` | `1000` |
| `ros__parameters.wait_for_service_timeout` | `1000` |
| `ros__parameters.action_server_result_timeout` | `900.0` |
| `ros__parameters.navigators` | `["navigate_to_pose", "navigate_through_poses"]` |
| `ros__parameters.navigate_to_pose.plugin` | `"nav2_bt_navigator::NavigateToPoseNavigator"` |
| `ros__parameters.navigate_through_poses.plugin` | `"nav2_bt_navigator::NavigateThroughPosesNavigator"` |
| `ros__parameters.default_nav_to_pose_bt_xml` | `"$(find-pkg-share ffw_navigation)/config/bt/nav_modes_1109.xml"` |
| `ros__parameters.default_nav_through_poses_bt_xml` | `"$(find-pkg-share ffw_navigation)/config/bt/nav_modes_1109.xml"` |
| `ros__parameters.plugin_lib_names` | `["is_path_length_under_plugin"]` |
| `ros__parameters.error_code_names` | `["compute_path_error_code", "follow_path_error_code"]` |

## controller_server

| 파라미터 | 값 |
|---|---|
| `ros__parameters.controller_frequency` | `20.0` |
| `ros__parameters.transform_tolerance` | `0.3` |
| `ros__parameters.min_x_velocity_threshold` | `0.001` |
| `ros__parameters.min_y_velocity_threshold` | `0.001` |
| `ros__parameters.min_theta_velocity_threshold` | `0.001` |
| `ros__parameters.failure_tolerance` | `1.0` |
| `ros__parameters.progress_checker_plugins` | `["progress_checker"]` |
| `ros__parameters.goal_checker_plugins` | `["general_goal_checker"]` |
| `ros__parameters.controller_plugins` | `["OmniController", "CurveController"]` |
| `ros__parameters.progress_checker.plugin` | `"nav2_controller::PoseProgressChecker"` |
| `ros__parameters.progress_checker.required_movement_angle` | `0.02` |
| `ros__parameters.progress_checker.required_movement_radius` | `0.02` |
| `ros__parameters.progress_checker.movement_time_allowance` | `20.0` |
| `ros__parameters.general_goal_checker.plugin` | `"nav2_controller::SimpleGoalChecker"` |
| `ros__parameters.general_goal_checker.xy_goal_tolerance` | `0.025` |
| `ros__parameters.general_goal_checker.yaw_goal_tolerance` | `0.02` |
| `ros__parameters.general_goal_checker.stateful` | `false` |
| `ros__parameters.OmniController.plugin` | `"nav2_mppi_controller::MPPIController"` |
| `ros__parameters.OmniController.time_steps` | `40` |
| `ros__parameters.OmniController.model_dt` | `0.05` |
| `ros__parameters.OmniController.batch_size` | `1200` |
| `ros__parameters.OmniController.motion_model` | `"Omni"` |
| `ros__parameters.OmniController.vx_std` | `0.15` |
| `ros__parameters.OmniController.vy_std` | `0.15` |
| `ros__parameters.OmniController.wz_std` | `0.35` |
| `ros__parameters.OmniController.vx_max` | `0.35` |
| `ros__parameters.OmniController.vx_min` | `-0.35` |
| `ros__parameters.OmniController.vy_max` | `0.35` |
| `ros__parameters.OmniController.vy_min` | `-0.35` |
| `ros__parameters.OmniController.wz_max` | `0.7` |
| `ros__parameters.OmniController.ax_max` | `0.5` |
| `ros__parameters.OmniController.ax_min` | `-0.5` |
| `ros__parameters.OmniController.ay_max` | `0.5` |
| `ros__parameters.OmniController.ay_min` | `-0.5` |
| `ros__parameters.OmniController.az_max` | `1.2` |
| `ros__parameters.OmniController.iteration_count` | `4` |
| `ros__parameters.OmniController.temperature` | `0.25` |
| `ros__parameters.OmniController.gamma` | `0.018` |
| `ros__parameters.OmniController.visualize` | `false` |
| `ros__parameters.OmniController.TrajectoryVisualizer.trajectory_step` | `5` |
| `ros__parameters.OmniController.TrajectoryVisualizer.time_step` | `3` |
| `ros__parameters.OmniController.critics` | `["ConstraintCritic", "CostCritic", "GoalCritic", "GoalAngleCritic", "PathFollowCritic"]` |
| `ros__parameters.OmniController.ConstraintCritic.enabled` | `true` |
| `ros__parameters.OmniController.ConstraintCritic.cost_power` | `1` |
| `ros__parameters.OmniController.ConstraintCritic.cost_weight` | `4.0` |
| `ros__parameters.OmniController.GoalCritic.enabled` | `true` |
| `ros__parameters.OmniController.GoalCritic.cost_power` | `1` |
| `ros__parameters.OmniController.GoalCritic.cost_weight` | `5.0` |
| `ros__parameters.OmniController.GoalCritic.threshold_to_consider` | `1.2` |
| `ros__parameters.OmniController.GoalAngleCritic.enabled` | `true` |
| `ros__parameters.OmniController.GoalAngleCritic.cost_power` | `1` |
| `ros__parameters.OmniController.GoalAngleCritic.cost_weight` | `5.0` |
| `ros__parameters.OmniController.GoalAngleCritic.threshold_to_consider` | `0.25` |
| `ros__parameters.OmniController.CostCritic.enabled` | `true` |
| `ros__parameters.OmniController.CostCritic.cost_power` | `1` |
| `ros__parameters.OmniController.CostCritic.cost_weight` | `4.0` |
| `ros__parameters.OmniController.CostCritic.critical_cost` | `300.0` |
| `ros__parameters.OmniController.CostCritic.consider_footprint` | `true` |
| `ros__parameters.OmniController.CostCritic.collision_cost` | `1000000.0` |
| `ros__parameters.OmniController.CostCritic.near_goal_distance` | `1.0` |
| `ros__parameters.OmniController.CostCritic.trajectory_point_step` | `2` |
| `ros__parameters.OmniController.PathFollowCritic.enabled` | `true` |
| `ros__parameters.OmniController.PathFollowCritic.cost_power` | `1` |
| `ros__parameters.OmniController.PathFollowCritic.cost_weight` | `5.0` |
| `ros__parameters.OmniController.PathFollowCritic.offset_from_furthest` | `1` |
| `ros__parameters.OmniController.PathFollowCritic.threshold_to_consider` | `1.2` |
| `ros__parameters.CurveController.plugin` | `"nav2_mppi_controller::MPPIController"` |
| `ros__parameters.CurveController.time_steps` | `40` |
| `ros__parameters.CurveController.model_dt` | `0.05` |
| `ros__parameters.CurveController.batch_size` | `1200` |
| `ros__parameters.CurveController.motion_model` | `"Omni"` |
| `ros__parameters.CurveController.vx_std` | `0.17` |
| `ros__parameters.CurveController.vy_std` | `0.12` |
| `ros__parameters.CurveController.wz_std` | `0.3` |
| `ros__parameters.CurveController.vx_max` | `0.35` |
| `ros__parameters.CurveController.vx_min` | `0.0` |
| `ros__parameters.CurveController.vy_max` | `0.25` |
| `ros__parameters.CurveController.vy_min` | `-0.25` |
| `ros__parameters.CurveController.wz_max` | `0.7` |
| `ros__parameters.CurveController.ax_max` | `0.5` |
| `ros__parameters.CurveController.ax_min` | `-0.5` |
| `ros__parameters.CurveController.ay_max` | `0.5` |
| `ros__parameters.CurveController.ay_min` | `-0.5` |
| `ros__parameters.CurveController.az_max` | `1.2` |
| `ros__parameters.CurveController.iteration_count` | `1` |
| `ros__parameters.CurveController.temperature` | `0.27` |
| `ros__parameters.CurveController.gamma` | `0.02` |
| `ros__parameters.CurveController.visualize` | `false` |
| `ros__parameters.CurveController.TrajectoryVisualizer.trajectory_step` | `5` |
| `ros__parameters.CurveController.TrajectoryVisualizer.time_step` | `3` |
| `ros__parameters.CurveController.critics` | `["ConstraintCritic", "CostCritic", "GoalCritic", "GoalAngleCritic", "PathAlignCritic", "PathFollowCritic", "PathAngleCritic", "PreferForwardCritic"]` |
| `ros__parameters.CurveController.ConstraintCritic.enabled` | `true` |
| `ros__parameters.CurveController.ConstraintCritic.cost_power` | `1` |
| `ros__parameters.CurveController.ConstraintCritic.cost_weight` | `4.0` |
| `ros__parameters.CurveController.GoalCritic.enabled` | `true` |
| `ros__parameters.CurveController.GoalCritic.cost_power` | `1` |
| `ros__parameters.CurveController.GoalCritic.cost_weight` | `5.0` |
| `ros__parameters.CurveController.GoalCritic.threshold_to_consider` | `1.2` |
| `ros__parameters.CurveController.GoalAngleCritic.enabled` | `true` |
| `ros__parameters.CurveController.GoalAngleCritic.cost_power` | `1` |
| `ros__parameters.CurveController.GoalAngleCritic.cost_weight` | `2.0` |
| `ros__parameters.CurveController.GoalAngleCritic.threshold_to_consider` | `0.3` |
| `ros__parameters.CurveController.PreferForwardCritic.enabled` | `true` |
| `ros__parameters.CurveController.PreferForwardCritic.cost_power` | `1` |
| `ros__parameters.CurveController.PreferForwardCritic.cost_weight` | `9.0` |
| `ros__parameters.CurveController.PreferForwardCritic.threshold_to_consider` | `0.5` |
| `ros__parameters.CurveController.CostCritic.enabled` | `true` |
| `ros__parameters.CurveController.CostCritic.cost_power` | `1` |
| `ros__parameters.CurveController.CostCritic.cost_weight` | `4.2` |
| `ros__parameters.CurveController.CostCritic.critical_cost` | `300.0` |
| `ros__parameters.CurveController.CostCritic.consider_footprint` | `true` |
| `ros__parameters.CurveController.CostCritic.collision_cost` | `1000000.0` |
| `ros__parameters.CurveController.CostCritic.near_goal_distance` | `1.0` |
| `ros__parameters.CurveController.CostCritic.trajectory_point_step` | `2` |
| `ros__parameters.CurveController.PathAlignCritic.enabled` | `true` |
| `ros__parameters.CurveController.PathAlignCritic.cost_power` | `1` |
| `ros__parameters.CurveController.PathAlignCritic.cost_weight` | `14.0` |
| `ros__parameters.CurveController.PathAlignCritic.max_path_occupancy_ratio` | `0.05` |
| `ros__parameters.CurveController.PathAlignCritic.trajectory_point_step` | `2` |
| `ros__parameters.CurveController.PathAlignCritic.threshold_to_consider` | `1.0` |
| `ros__parameters.CurveController.PathAlignCritic.offset_from_furthest` | `15` |
| `ros__parameters.CurveController.PathAlignCritic.use_path_orientations` | `true` |
| `ros__parameters.CurveController.PathFollowCritic.enabled` | `true` |
| `ros__parameters.CurveController.PathFollowCritic.cost_power` | `1` |
| `ros__parameters.CurveController.PathFollowCritic.cost_weight` | `6.0` |
| `ros__parameters.CurveController.PathFollowCritic.offset_from_furthest` | `5` |
| `ros__parameters.CurveController.PathFollowCritic.threshold_to_consider` | `1.2` |
| `ros__parameters.CurveController.PathAngleCritic.enabled` | `true` |
| `ros__parameters.CurveController.PathAngleCritic.cost_power` | `1` |
| `ros__parameters.CurveController.PathAngleCritic.cost_weight` | `6.0` |
| `ros__parameters.CurveController.PathAngleCritic.offset_from_furthest` | `3` |
| `ros__parameters.CurveController.PathAngleCritic.threshold_to_consider` | `0.5` |
| `ros__parameters.CurveController.PathAngleCritic.max_angle_to_furthest` | `0.4` |
| `ros__parameters.CurveController.PathAngleCritic.mode` | `0` |

## local_costmap

| 파라미터 | 값 |
|---|---|
| `local_costmap.ros__parameters.update_frequency` | `10.0` |
| `local_costmap.ros__parameters.publish_frequency` | `2.0` |
| `local_costmap.ros__parameters.global_frame` | `"odom"` |
| `local_costmap.ros__parameters.robot_base_frame` | `"base_link"` |
| `local_costmap.ros__parameters.transform_tolerance` | `0.3` |
| `local_costmap.ros__parameters.rolling_window` | `true` |
| `local_costmap.ros__parameters.width` | `3` |
| `local_costmap.ros__parameters.height` | `3` |
| `local_costmap.ros__parameters.resolution` | `0.025` |
| `local_costmap.ros__parameters.footprint` | `"[[0.25, 0.266], [0.25, -0.266], [0.24, -0.303], [0.216, -0.337], [0.163, -0.366], [0.112, -0.366], [-0.322, -0.236], [-0.363, -0.209], [-0.403, -0.052], [-0.403, 0.009], [-0.377, 0.166], [-0.362, 0.21], [-0.322, 0.236], [0.112, 0.366], [0.163, 0.366], [0.218, 0.335], [0.24, 0.303]]"` |
| `local_costmap.ros__parameters.footprint_padding` | `0.02` |
| `local_costmap.ros__parameters.plugins` | `["obstacle_layer", "inflation_layer"]` |
| `local_costmap.ros__parameters.inflation_layer.plugin` | `"nav2_costmap_2d::InflationLayer"` |
| `local_costmap.ros__parameters.inflation_layer.cost_scaling_factor` | `10.0` |
| `local_costmap.ros__parameters.inflation_layer.inflation_radius` | `0.48` |
| `local_costmap.ros__parameters.obstacle_layer.plugin` | `"nav2_costmap_2d::ObstacleLayer"` |
| `local_costmap.ros__parameters.obstacle_layer.enabled` | `true` |
| `local_costmap.ros__parameters.obstacle_layer.observation_sources` | `"scan"` |
| `local_costmap.ros__parameters.obstacle_layer.scan.topic` | `"/scan"` |
| `local_costmap.ros__parameters.obstacle_layer.scan.max_obstacle_height` | `2.0` |
| `local_costmap.ros__parameters.obstacle_layer.scan.clearing` | `true` |
| `local_costmap.ros__parameters.obstacle_layer.scan.inf_is_valid` | `true` |
| `local_costmap.ros__parameters.obstacle_layer.scan.marking` | `true` |
| `local_costmap.ros__parameters.obstacle_layer.scan.data_type` | `"LaserScan"` |
| `local_costmap.ros__parameters.obstacle_layer.scan.raytrace_max_range` | `3.0` |
| `local_costmap.ros__parameters.obstacle_layer.scan.raytrace_min_range` | `0.0` |
| `local_costmap.ros__parameters.obstacle_layer.scan.obstacle_max_range` | `2.5` |
| `local_costmap.ros__parameters.obstacle_layer.scan.obstacle_min_range` | `0.0` |
| `local_costmap.ros__parameters.static_layer.plugin` | `"nav2_costmap_2d::StaticLayer"` |
| `local_costmap.ros__parameters.static_layer.map_subscribe_transient_local` | `true` |
| `local_costmap.ros__parameters.always_send_full_costmap` | `true` |

## global_costmap

| 파라미터 | 값 |
|---|---|
| `global_costmap.ros__parameters.update_frequency` | `1.0` |
| `global_costmap.ros__parameters.publish_frequency` | `1.0` |
| `global_costmap.ros__parameters.global_frame` | `"map"` |
| `global_costmap.ros__parameters.robot_base_frame` | `"base_link"` |
| `global_costmap.ros__parameters.transform_tolerance` | `0.3` |
| `global_costmap.ros__parameters.footprint` | `"[[0.25, 0.266], [0.25, -0.266], [0.24, -0.303], [0.216, -0.337], [0.163, -0.366], [0.112, -0.366], [-0.322, -0.236], [-0.363, -0.209], [-0.403, -0.052], [-0.403, 0.009], [-0.377, 0.166], [-0.362, 0.21], [-0.322, 0.236], [0.112, 0.366], [0.163, 0.366], [0.218, 0.335], [0.24, 0.303]]"` |
| `global_costmap.ros__parameters.footprint_padding` | `0.02` |
| `global_costmap.ros__parameters.resolution` | `0.05` |
| `global_costmap.ros__parameters.track_unknown_space` | `true` |
| `global_costmap.ros__parameters.plugins` | `["static_layer", "obstacle_layer", "inflation_layer"]` |
| `global_costmap.ros__parameters.obstacle_layer.plugin` | `"nav2_costmap_2d::ObstacleLayer"` |
| `global_costmap.ros__parameters.obstacle_layer.enabled` | `true` |
| `global_costmap.ros__parameters.obstacle_layer.observation_sources` | `"scan"` |
| `global_costmap.ros__parameters.obstacle_layer.scan.topic` | `"/scan"` |
| `global_costmap.ros__parameters.obstacle_layer.scan.max_obstacle_height` | `2.0` |
| `global_costmap.ros__parameters.obstacle_layer.scan.clearing` | `true` |
| `global_costmap.ros__parameters.obstacle_layer.scan.marking` | `false` |
| `global_costmap.ros__parameters.obstacle_layer.scan.data_type` | `"LaserScan"` |
| `global_costmap.ros__parameters.obstacle_layer.scan.raytrace_max_range` | `3.0` |
| `global_costmap.ros__parameters.obstacle_layer.scan.raytrace_min_range` | `0.0` |
| `global_costmap.ros__parameters.obstacle_layer.scan.obstacle_max_range` | `2.5` |
| `global_costmap.ros__parameters.obstacle_layer.scan.obstacle_min_range` | `0.0` |
| `global_costmap.ros__parameters.static_layer.plugin` | `"nav2_costmap_2d::StaticLayer"` |
| `global_costmap.ros__parameters.static_layer.map_subscribe_transient_local` | `true` |
| `global_costmap.ros__parameters.inflation_layer.plugin` | `"nav2_costmap_2d::InflationLayer"` |
| `global_costmap.ros__parameters.inflation_layer.cost_scaling_factor` | `5.0` |
| `global_costmap.ros__parameters.inflation_layer.inflation_radius` | `0.55` |
| `global_costmap.ros__parameters.always_send_full_costmap` | `true` |

## planner_server

| 파라미터 | 값 |
|---|---|
| `ros__parameters.expected_planner_frequency` | `20.0` |
| `ros__parameters.planner_plugins` | `["SmacPlannerHybrid"]` |
| `ros__parameters.costmap_update_timeout` | `1.0` |
| `ros__parameters.SmacPlannerHybrid.plugin` | `"nav2_smac_planner::SmacPlannerHybrid"` |
| `ros__parameters.SmacPlannerHybrid.tolerance` | `0.0` |
| `ros__parameters.SmacPlannerHybrid.allow_unknown` | `true` |
| `ros__parameters.SmacPlannerHybrid.use_final_approach_orientation` | `false` |
| `ros__parameters.SmacPlannerHybrid.minimum_turning_radius` | `0.0` |
| `ros__parameters.SmacPlannerHybrid.motion_model_for_search` | `"REEDS_SHEPP"` |
| `ros__parameters.SmacPlannerHybrid.allow_reverse` | `true` |
| `ros__parameters.SmacPlannerHybrid.angle_quantization_bins` | `24` |
| `ros__parameters.SmacPlannerHybrid.analytic_expansion_ratio` | `1.0` |
| `ros__parameters.SmacPlannerHybrid.max_iterations` | `40000` |
| `ros__parameters.SmacPlannerHybrid.max_on_approach_iterations` | `12000` |
| `ros__parameters.SmacPlannerHybrid.cost_travel_multiplier` | `1.0` |
| `ros__parameters.SmacPlannerHybrid.cost_heuristic_multiplier` | `2.5` |
| `ros__parameters.SmacPlannerHybrid.non_straight_penalty` | `10.5` |
| `ros__parameters.SmacPlannerHybrid.change_penalty` | `2.0` |
| `ros__parameters.SmacPlannerHybrid.rotation_penalty` | `1.5` |
| `ros__parameters.SmacPlannerHybrid.downsample_costmap` | `false` |
| `ros__parameters.SmacPlannerHybrid.downsampling_factor` | `1` |
| `ros__parameters.SmacPlannerHybrid.smooth_path` | `true` |
| `ros__parameters.SmacPlannerHybrid.cache_obstacle_heuristic` | `true` |
| `ros__parameters.SmacPlannerHybrid.smoother.max_iterations` | `800` |
| `ros__parameters.SmacPlannerHybrid.smoother.w_smooth` | `0.9` |
| `ros__parameters.SmacPlannerHybrid.smoother.w_data` | `0.05` |
| `ros__parameters.SmacPlannerHybrid.smoother.tolerance` | `1e-10` |

## smoother_server

| 파라미터 | 값 |
|---|---|
| `ros__parameters.smoother_plugins` | `["simple_smoother"]` |
| `ros__parameters.simple_smoother.plugin` | `"nav2_smoother::SimpleSmoother"` |
| `ros__parameters.simple_smoother.tolerance` | `1e-10` |
| `ros__parameters.simple_smoother.max_its` | `200` |
| `ros__parameters.simple_smoother.do_refinement` | `false` |

## behavior_server

| 파라미터 | 값 |
|---|---|
| `ros__parameters.local_costmap_topic` | `"local_costmap/costmap_raw"` |
| `ros__parameters.global_costmap_topic` | `"global_costmap/costmap_raw"` |
| `ros__parameters.local_footprint_topic` | `"local_costmap/published_footprint"` |
| `ros__parameters.global_footprint_topic` | `"global_costmap/published_footprint"` |
| `ros__parameters.cycle_frequency` | `10.0` |
| `ros__parameters.behavior_plugins` | `["spin", "backup", "drive_on_heading", "assisted_teleop", "wait"]` |
| `ros__parameters.spin.plugin` | `"nav2_behaviors::Spin"` |
| `ros__parameters.backup.plugin` | `"nav2_behaviors::BackUp"` |
| `ros__parameters.drive_on_heading.plugin` | `"nav2_behaviors::DriveOnHeading"` |
| `ros__parameters.wait.plugin` | `"nav2_behaviors::Wait"` |
| `ros__parameters.assisted_teleop.plugin` | `"nav2_behaviors::AssistedTeleop"` |
| `ros__parameters.local_frame` | `"odom"` |
| `ros__parameters.global_frame` | `"map"` |
| `ros__parameters.robot_base_frame` | `"base_link"` |
| `ros__parameters.transform_tolerance` | `0.3` |
| `ros__parameters.simulate_ahead_time` | `2.0` |
| `ros__parameters.max_rotational_vel` | `1.0` |
| `ros__parameters.min_rotational_vel` | `0.4` |
| `ros__parameters.rotational_acc_lim` | `3.2` |

## waypoint_follower

| 파라미터 | 값 |
|---|---|
| `ros__parameters.loop_rate` | `20` |
| `ros__parameters.stop_on_failure` | `false` |
| `ros__parameters.action_server_result_timeout` | `900.0` |
| `ros__parameters.waypoint_task_executor_plugin` | `"wait_at_waypoint"` |
| `ros__parameters.wait_at_waypoint.plugin` | `"nav2_waypoint_follower::WaitAtWaypoint"` |
| `ros__parameters.wait_at_waypoint.enabled` | `true` |
| `ros__parameters.wait_at_waypoint.waypoint_pause_duration` | `5` |

## velocity_smoother

| 파라미터 | 값 |
|---|---|
| `ros__parameters.smoothing_frequency` | `20.0` |
| `ros__parameters.scale_velocities` | `true` |
| `ros__parameters.feedback` | `"OPEN_LOOP"` |
| `ros__parameters.max_velocity` | `[0.35, 0.35, 0.7]` |
| `ros__parameters.min_velocity` | `[-0.35, -0.35, -0.7]` |
| `ros__parameters.max_accel` | `[0.5, 0.5, 1.2]` |
| `ros__parameters.max_decel` | `[-0.5, -0.5, -1.2]` |
| `ros__parameters.odom_topic` | `"odom"` |
| `ros__parameters.odom_duration` | `0.1` |
| `ros__parameters.deadband_velocity` | `[0.0, 0.0, 0.0]` |
| `ros__parameters.velocity_timeout` | `1.0` |

## collision_monitor

| 파라미터 | 값 |
|---|---|
| `ros__parameters.base_frame_id` | `"base_link"` |
| `ros__parameters.odom_frame_id` | `"odom"` |
| `ros__parameters.cmd_vel_in_topic` | `"cmd_vel_smoothed"` |
| `ros__parameters.cmd_vel_out_topic` | `"cmd_vel"` |
| `ros__parameters.state_topic` | `"collision_monitor_state"` |
| `ros__parameters.transform_tolerance` | `0.2` |
| `ros__parameters.source_timeout` | `1.0` |
| `ros__parameters.base_shift_correction` | `true` |
| `ros__parameters.stop_pub_timeout` | `2.0` |
| `ros__parameters.polygons` | `["FootprintApproach"]` |
| `ros__parameters.FootprintApproach.type` | `"polygon"` |
| `ros__parameters.FootprintApproach.action_type` | `"approach"` |
| `ros__parameters.FootprintApproach.footprint_topic` | `"/local_costmap/published_footprint"` |
| `ros__parameters.FootprintApproach.time_before_collision` | `1.0` |
| `ros__parameters.FootprintApproach.simulation_time_step` | `0.1` |
| `ros__parameters.FootprintApproach.min_points` | `6` |
| `ros__parameters.FootprintApproach.visualize` | `false` |
| `ros__parameters.FootprintApproach.enabled` | `false` |
| `ros__parameters.observation_sources` | `["scan"]` |
| `ros__parameters.scan.type` | `"scan"` |
| `ros__parameters.scan.topic` | `"scan"` |
| `ros__parameters.scan.min_height` | `0.15` |
| `ros__parameters.scan.max_height` | `2.0` |
| `ros__parameters.scan.enabled` | `true` |

## docking_server

| 파라미터 | 값 |
|---|---|
| `ros__parameters.dock_plugins` | `["simple_charging_dock"]` |
| `ros__parameters.simple_charging_dock.plugin` | `"opennav_docking::SimpleChargingDock"` |
| `ros__parameters.simple_charging_dock.docking_threshold` | `0.05` |
| `ros__parameters.simple_charging_dock.staging_x_offset` | `-0.7` |
| `ros__parameters.simple_charging_dock.use_external_detection_pose` | `true` |
| `ros__parameters.simple_charging_dock.use_battery_status` | `false` |
| `ros__parameters.simple_charging_dock.use_stall_detection` | `false` |
| `ros__parameters.simple_charging_dock.external_detection_timeout` | `1.0` |
| `ros__parameters.simple_charging_dock.external_detection_translation_x` | `-0.18` |
| `ros__parameters.simple_charging_dock.external_detection_translation_y` | `0.0` |
| `ros__parameters.simple_charging_dock.external_detection_rotation_roll` | `-1.57` |
| `ros__parameters.simple_charging_dock.external_detection_rotation_pitch` | `-1.57` |
| `ros__parameters.simple_charging_dock.external_detection_rotation_yaw` | `0.0` |
| `ros__parameters.simple_charging_dock.filter_coef` | `0.1` |
| `ros__parameters.controller.k_phi` | `3.0` |
| `ros__parameters.controller.k_delta` | `2.0` |
| `ros__parameters.controller.v_linear_min` | `0.15` |
| `ros__parameters.controller.v_linear_max` | `0.15` |
| `ros__parameters.controller.use_collision_detection` | `true` |
| `ros__parameters.controller.costmap_topic` | `"local_costmap/costmap_raw"` |
| `ros__parameters.controller.footprint_topic` | `"local_costmap/published_footprint"` |
| `ros__parameters.controller.transform_tolerance` | `0.1` |
| `ros__parameters.controller.projection_time` | `5.0` |
| `ros__parameters.controller.simulation_step` | `0.1` |
| `ros__parameters.controller.dock_collision_threshold` | `0.3` |

## amcl

| 파라미터 | 값 |
|---|---|
| `ros__parameters.alpha1` | `0.4` |
| `ros__parameters.alpha2` | `0.4` |
| `ros__parameters.alpha3` | `0.4` |
| `ros__parameters.alpha4` | `0.4` |
| `ros__parameters.alpha5` | `0.4` |
| `ros__parameters.base_frame_id` | `"base_link"` |
| `ros__parameters.beam_skip_distance` | `0.5` |
| `ros__parameters.beam_skip_error_threshold` | `0.9` |
| `ros__parameters.beam_skip_threshold` | `0.3` |
| `ros__parameters.do_beamskip` | `false` |
| `ros__parameters.global_frame_id` | `"map"` |
| `ros__parameters.lambda_short` | `0.1` |
| `ros__parameters.laser_likelihood_max_dist` | `2.0` |
| `ros__parameters.laser_max_range` | `100.0` |
| `ros__parameters.laser_min_range` | `-1.0` |
| `ros__parameters.laser_model_type` | `"likelihood_field"` |
| `ros__parameters.max_beams` | `80` |
| `ros__parameters.max_particles` | `2000` |
| `ros__parameters.min_particles` | `800` |
| `ros__parameters.odom_frame_id` | `"odom"` |
| `ros__parameters.pf_err` | `0.05` |
| `ros__parameters.pf_z` | `0.99` |
| `ros__parameters.recovery_alpha_fast` | `0.0` |
| `ros__parameters.recovery_alpha_slow` | `0.0` |
| `ros__parameters.resample_interval` | `1` |
| `ros__parameters.robot_model_type` | `"nav2_amcl::OmniMotionModel"` |
| `ros__parameters.save_pose_rate` | `0.5` |
| `ros__parameters.sigma_hit` | `0.2` |
| `ros__parameters.tf_broadcast` | `true` |
| `ros__parameters.transform_tolerance` | `1.0` |
| `ros__parameters.update_min_a` | `0.02` |
| `ros__parameters.update_min_d` | `0.02` |
| `ros__parameters.z_hit` | `0.5` |
| `ros__parameters.z_max` | `0.05` |
| `ros__parameters.z_rand` | `0.5` |
| `ros__parameters.z_short` | `0.05` |
| `ros__parameters.scan_topic` | `"/scan"` |
| `ros__parameters.map_topic` | `"map"` |
| `ros__parameters.set_initial_pose` | `true` |
| `ros__parameters.always_reset_initial_pose` | `false` |
| `ros__parameters.first_map_only` | `false` |
| `ros__parameters.initial_pose.x` | `0.0` |
| `ros__parameters.initial_pose.y` | `0.0` |
| `ros__parameters.initial_pose.z` | `0.0` |
| `ros__parameters.initial_pose.yaw` | `0.0` |

## SH5 베이스 controller

파일: `ffw_bringup/config/ffw_sh5_rev1_follower/ffw_sh5_follower_ai_hardware_controller.yaml`

| 파라미터 | 값 |
|---|---|
| `steering_joint_names` | `["left_wheel_steer", "right_wheel_steer", "rear_wheel_steer"]` |
| `wheel_joint_names` | `["left_wheel_drive", "right_wheel_drive", "rear_wheel_drive"]` |
| `wheel_radius` | `0.0825` |
| `cmd_vel_timeout` | `1.0` |
| `linear_vel_deadband` | `0.005` |
| `angular_vel_deadband` | `0.005` |
| `module_x_offsets` | `[0.1371, 0.1371, -0.2899]` |
| `module_y_offsets` | `[0.2554, -0.2554, 0.0]` |
| `module_angle_offsets` | `[0.0, 0.0, 0.0]` |
| `module_steering_limit_lower` | `[-6.28, -6.28, -6.28]` |
| `module_steering_limit_upper` | `[6.28, 6.28, 6.28]` |
| `steering_to_wheel_y_offsets` | `[0.0, -0.0, 0.0]` |
| `module_wheel_speed_limit_lower` | `[-50.0, -50.0, -50.0]` |
| `module_wheel_speed_limit_upper` | `[50.0, 50.0, 50.0]` |
| `enabled_steering_flip` | `true` |
| `enabled_steering_angular_velocity_limit` | `true` |
| `steering_angular_velocity_limit` | `100.0` |
| `steering_alignment_angle_error_threshold` | `1.0` |
| `steering_alignment_start_angle_error_threshold` | `0.01` |
| `steering_alignment_start_speed_error_threshold` | `0.1` |
| `enabled_open_loop` | `false` |
| `enabled_wheel_saturation_scaling` | `true` |
| `odom_solver_method` | `"svd"` |
| `odom_integration_method` | `"euler"` |
| `odom_source` | `"feedback"` |
| `base_frame_id` | `"base_link"` |
| `odom_frame_id` | `"odom"` |
| `enable_odom_tf` | `true` |
| `pose_covariance_diagonal` | `[0.001, 0.001, 0.001, 0.001, 0.001, 0.001]` |
| `twist_covariance_diagonal` | `[0.001, 0.001, 0.001, 0.001, 0.001, 0.001]` |
| `velocity_rolling_window_size` | `10` |
| `enable_visualization` | `true` |
| `visualization_marker_topic` | `"swerve_visualization_markers"` |
| `visualization_update_time` | `0.1` |
| `enable_direct_joint_commands` | `false` |
| `direct_joint_command_timeout_sec` | `1.0` |
| `direct_joint_command_topic` | `"~/direct_joint_commands"` |
| `enabled_steering_angular_limit` | `false` |
| `enabled_speed_limits` | `false` |
| `publish_limited_velocity` | `true` |
| `linear.x.has_velocity_limits` | `true` |
| `linear.x.max_velocity` | `1.5` |
| `linear.x.min_velocity` | `-1.5` |
| `linear.x.has_acceleration_limits` | `true` |
| `linear.x.max_acceleration` | `0.5` |
| `linear.x.min_acceleration` | `-0.5` |
| `linear.x.has_jerk_limits` | `true` |
| `linear.x.max_jerk` | `1.0` |
| `linear.x.min_jerk` | `-1.0` |
| `linear.y.has_velocity_limits` | `true` |
| `linear.y.max_velocity` | `1.5` |
| `linear.y.min_velocity` | `-1.5` |
| `linear.y.has_acceleration_limits` | `true` |
| `linear.y.max_acceleration` | `0.5` |
| `linear.y.min_acceleration` | `-0.5` |
| `linear.y.has_jerk_limits` | `true` |
| `linear.y.max_jerk` | `1.0` |
| `linear.y.min_jerk` | `-1.0` |
| `angular.z.has_velocity_limits` | `false` |
| `angular.z.max_velocity` | `1.7` |
| `angular.z.has_acceleration_limits` | `true` |
| `angular.z.max_acceleration` | `1.5` |
| `angular.z.has_jerk_limits` | `true` |
| `angular.z.max_jerk` | `3.0` |
