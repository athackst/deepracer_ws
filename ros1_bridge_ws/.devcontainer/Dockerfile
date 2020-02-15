FROM athackst/ros2:eloquent-dev

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# install melodic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
  && apt-get update \
  && apt-get install -y ros-melodic-ros-base \
  && rm -rf /var/lib/apt/lists/*

# Deps for building the bridge
RUN apt-get update && apt-get install -y \
  # Test deps
  ros-eloquent-demo-nodes-cpp \
  ros-eloquent-launch-testing \
  ros-eloquent-launch-testing-ament-cmake \
  ros-eloquent-launch-testing-ros \
  ros-melodic-rospy-tutorials \
  ros-melodic-roscpp-tutorials \
  # Build deps
  libboost-filesystem-dev \
  libboost-math-dev \
  libboost-regex-dev \
  libboost-signals-dev \
  libboost-thread-dev \
  liblog4cxx-dev \
  && rm -rf /var/lib/apt/lists/*

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #  Add sudo support for the non-root user
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# Set up the environment
ENV LD_LIBRARY_PATH=/opt/ros/eloquent/lib:/opt/ros/melodic/lib
ENV AMENT_PREFIX_PATH=/opt/ros/eloquent
ENV ROS_ETC_DIR=/opt/ros/melodic/etc/ros
ENV COLCON_PREFIX_PATH=/opt/ros/eloquent
ENV ROS_ROOT=/opt/ros/melodic/share/ros
ENV ROS_MASTER_URI=http://localhost:11311
ENV ROS_VERSION=2
ENV ROS_LOCALHOST_ONLY=0
ENV ROS_PYTHON_VERSION=3
ENV PYTHONPATH=/opt/ros/eloquent/lib/python3.6/site-packages:/opt/ros/melodic/lib/python2.7/dist-packages
ENV ROS_PACKAGE_PATH=/opt/ros/melodic/share
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PATH=/opt/ros/eloquent/bin:/opt/ros/melodic/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PKG_CONFIG_PATH=/opt/ros/melodic/lib/pkgconfig
ENV CMAKE_PREFIX_PATH=/opt/ros/eloquent:/opt/ros/melodic


CMD ["bash"]
