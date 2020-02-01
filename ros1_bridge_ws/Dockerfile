# Dockerfile to bridge the ros1 and ros2 messages
# Build the ros1 messages
FROM athackst/ros:melodic-dev as ros1_builder

COPY ros_ws/src/aws_deepracer_msgs/ /workspaces/ros/src/aws_deepracer_msgs/
WORKDIR /workspaces/ros
RUN catkin_make install -DCMAKE_INSTALL_PREFIX=/opt/ros/melodic

# Build the ros2 messages
FROM athackst/ros2:eloquent-dev as ros2_builder

RUN apt-get update && apt-get install -y \
  ros-eloquent-launch-testing \
  ros-eloquent-launch-testing-ament-cmake \
  ros-eloquent-launch-testing-ros \
  libboost-filesystem-dev \
  libboost-math-dev \
  libboost-regex-dev \
  libboost-signals-dev \
  libboost-thread-dev \
  liblog4cxx-dev \
  && rm -rf /var/lib/apt/lists/*

COPY ros2_ws/src/aws_deepracer_msgs/ /workspaces/ros2/src/aws_deepracer_msgs/
WORKDIR /workspaces/ros2
RUN colcon build --merge-install --install-base /opt/ros/eloquent

# install melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
  && apt-get update \
  && apt-get install -y ros-melodic-ros-base \
  && rm -rf /var/lib/apt/lists/*

COPY --from=ros1_builder /opt/ros/melodic /opt/ros/melodic

ENV LD_LIBRARY_PATH=/opt/ros/melodic/lib:/opt/ros/eloquent/lib
ENV AMENT_PREFIX_PATH=/opt/ros/eloquent
ENV ROS_ETC_DIR=/opt/ros/melodic/etc/ros
ENV COLCON_PREFIX_PATH=/opt/ros/eloquent
ENV ROS_ROOT=/opt/ros/melodic/share/ros
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_VERSION=2
ENV ROS_LOCALHOST_ONLY=0
ENV ROS_PYTHON_VERSION=3
ENV PYTHONPATH=/opt/ros/melodic/lib/python2.7/dist-packages:/opt/ros/eloquent/lib/python3.6/site-packages
ENV ROS_PACKAGE_PATH=/opt/ros/melodic/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/melodic/bin:/opt/ros/eloquent/bin:$PATH
ENV PKG_CONFIG_PATH=/opt/ros/melodic/lib/pkgconfig

# Build the bridge
WORKDIR /workspaces/ros1_bridge
COPY ros1_bridge_ws/src/ src/
RUN colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure

RUN bash -c "source install/local_setup.bash && ros2 run ros1_bridge dynamic_bridge --print-pairs"

CMD ["bash"]