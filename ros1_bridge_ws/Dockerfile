# Dockerfile to bridge the ros1 and ros2 messages
#
# Build the ros1 messages
# ------------------------
FROM athackst/ros:noetic-dev as ros1_builder

COPY ros_ws/src/aws_deepracer_msgs/ /workspaces/ros/src/aws_deepracer_msgs/
WORKDIR /workspaces/ros
RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
  && catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ros/${ROS_DISTRO}

#
# Build the ros2 messages
# ------------------------
FROM athackst/ros2:foxy-dev as ros2_builder

COPY ros2_ws/src/aws_deepracer_msgs/ /workspaces/ros2/src/aws_deepracer_msgs/
WORKDIR /workspaces/ros2
RUN printenv
RUN colcon build --merge-install --install-base /opt/ros/${ROS2_DISTRO}

#
# Build the ros1 bridge
# ------------------------
FROM athackst/ros2:foxy-dev as ros1_bridge_builder
ENV ROS2_DISTRO="foxy"
ENV ROS1_DISTRO="noetic"

# install melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
  && apt-get update \
  && apt-get install -y ros-${ROS1_DISTRO}-ros-base \
  && rm -rf /var/lib/apt/lists/*

COPY --from=ros1_builder /opt/ros/${ROS1_DISTRO} /opt/ros/${ROS1_DISTRO}
COPY --from=ros2_builder /opt/ros/${ROS2_DISTRO} /opt/ros/${ROS2_DISTRO}

# Deps for building the bridge
RUN apt-get update && apt-get install -y \
  # Test deps
  ros-${ROS2_DISTRO}-demo-nodes-cpp \
  ros-${ROS2_DISTRO}-launch-testing \
  ros-${ROS2_DISTRO}-launch-testing-ament-cmake \
  ros-${ROS2_DISTRO}-launch-testing-ros \
  ros-${ROS1_DISTRO}-rospy-tutorials \
  ros-${ROS1_DISTRO}-roscpp-tutorials \
  # Build deps
  libboost-filesystem-dev \
  libboost-math-dev \
  libboost-regex-dev \
  # libboost-signals-dev \
  libboost-thread-dev \
  liblog4cxx-dev \
  && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/opt/ros/${ROS2_DISTRO}/lib:/opt/ros/${ROS1_DISTRO}/lib
ENV AMENT_PREFIX_PATH=/opt/ros/${ROS2_DISTRO}
ENV ROS_ETC_DIR=/opt/ros/${ROS1_DISTRO}/etc/ros
ENV COLCON_PREFIX_PATH=/opt/ros/${ROS2_DISTRO}
ENV ROS_ROOT=/opt/ros/${ROS1_DISTRO}/share/ros
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_VERSION=2
ENV ROS_LOCALHOST_ONLY=0
ENV ROS_PYTHON_VERSION=3
ENV PYTHONPATH=/opt/ros/${ROS2_DISTRO}/lib/python3.8/site-packages:/opt/ros/${ROS2_DISTRO}/lib/python3.6/site-packages:/opt/ros/${ROS1_DISTRO}/lib/python3/dist-packages
ENV ROS_PACKAGE_PATH=/opt/ros/${ROS1_DISTRO}/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/${ROS2_DISTRO}/bin:/opt/ros/${ROS1_DISTRO}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH=/opt/ros/${ROS1_DISTRO}/lib/pkgconfig
ENV CMAKE_PREFIX_PATH=/opt/ros/${ROS2_DISTRO}:/opt/ros/${ROS1_DISTRO}

# Build the bridge
WORKDIR /workspaces/ros1_bridge
COPY ros1_bridge_ws/src/ src/
RUN colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure

RUN bash -c "source install/local_setup.bash && ros2 run ros1_bridge dynamic_bridge --print-pairs"

# Set up the environment for execution
ENV LD_LIBRARY_PATH=/workspaces/ros1_bridge/install/ros1_bridge/lib:/opt/ros/${ROS1_DISTRO}/lib:/opt/ros/eloquent/lib
ENV AMENT_PREFIX_PATH=/workspaces/ros1_bridge/install/ros1_bridge:/opt/ros/eloquent
ENV ROS_ETC_DIR=/opt/ros/${ROS1_DISTRO}/etc/ros
ENV CMAKE_PREFIX_PATH=/workspaces/ros1_bridge/install/ros1_bridge:/opt/ros/${ROS1_DISTRO}:/opt/ros/${ROS2_DISTRO}
ENV COLCON_PREFIX_PATH=/workspaces/ros1_bridge/install:/opt/ros/eloquent
ENV ROS_ROOT=/opt/ros/${ROS1_DISTRO}/share/ros
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_VERSION=1
ENV ROS_LOCALHOST_ONLY=0
ENV ROS_PYTHON_VERSION=3
ENV PYTHONPATH=/workspaces/ros1_bridge/install/ros1_bridge/lib/python3.6/site-packages:/opt/ros/${ROS1_DISTRO}/lib/python3.6/site-packages:/opt/ros/${ROS2_DISTRO}/lib/python3.6/site-packages
ENV ROS_PACKAGE_PATH=/opt/ros/${ROS1_DISTRO}/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/${ROS1_DISTRO}/bin:/opt/ros/eloquent/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH=/opt/ros/${ROS1_DISTRO}/lib/pkgconfig
ENV ROS_DISTRO=${ROS1_DISTRO}

CMD ["bash", "-c", "ros2 run ros1_bridge dynamic_bridge --bridge-all-pairs"]