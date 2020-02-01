#------- Builder stage
FROM athackst/ros:kinetic-dev as builder

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces/deepracer_ws/
COPY src ./src
RUN catkin_make -DCMAKE_INSTALL_PREFIX=/opt/deepracer_ws install

#------- Deployment stage
FROM athackst/ros:kinetic-base

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/deepracer_ws/ /opt/deepracer_ws/

# Set up environment
ENV ROS_PACKAGE_PATH=/opt/deepracer_ws/share:$ROS_PACKAGE_PATH
ENV LD_LIBRARY_PATH=/opt/deepracer_ws/lib:$LD_LIBRARY_PATH
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PYTHONPATH=/opt/deepracer_ws/lib/python2.7/dist-packages:$PYTHONPATH
ENV PKG_CONFIG_PATH=/opt/deepracer_ws/lib/pkgconfig:$PKG_CONFIG_PATH

COPY deepracer_joy.sh /opt/deepracer_ws/deepracer_joy.sh
CMD ["bash", "-c", "/opt/deepracer_ws/deepracer_joy.sh"]