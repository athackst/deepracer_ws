FROM athackst/ros:kinetic-base

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh

COPY install /opt/deepracer_ws/

# Set up environment
ENV ROS_PACKAGE_PATH=/opt/deepracer_ws/share:/workspaces/deepracer_ws/src:$ROS_PACKAGE_PATH
ENV LD_LIBRARY_PATH=/opt/deepracer_ws/lib:$LD_LIBRARY_PATH
ENV ROSLISP_PACKAGE_DIRECTORIES=
ENV PYTHONPATH=/opt/deepracer_ws/lib/python2.7/dist-packages:$PYTHONPATH
ENV PKG_CONFIG_PATH=/opt/deepracer_ws/lib/pkgconfig:$PKG_CONFIG_PATH

CMD ["bash"]