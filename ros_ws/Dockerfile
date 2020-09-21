# Build the workspace
FROM athackst/ros:kinetic-dev as builder

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh

COPY src/ /workspace/ros/src/
RUN  apt-get update && rosdep update \
  && rosdep install --from-paths src --ignore-src \
  && rm -rf /var/lib/apt/lists/* 

WORKDIR /workspaces/ros
RUN catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/${ROS_DISTRO} install

# Deploy the workspace
FROM athackst/ros:kinetic-base

COPY --from=builder /opt/ros/${ROS_DISTRO} /opt/ros/${ROS_DISTRO}
COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh

CMD ["bash"]