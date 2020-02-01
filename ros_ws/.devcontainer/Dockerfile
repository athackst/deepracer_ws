FROM athackst/ros:kinetic-dev

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh

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

# Set up environment
ENV ROS_PACKAGE_PATH=/workspaces/deepracer_ws/install/share:/workspaces/deepracer_ws/src:$ROS_PACKAGE_PATH
ENV LD_LIBRARY_PATH=/workspaces/deepracer_ws/install/lib:/workspaces/deepracer_ws/devel/lib:$LD_LIBRARY_PATH
ENV ROSLISP_PACKAGE_DIRECTORIES=/workspaces/deepracer_ws/devel/share/common-lisp
ENV PYTHONPATH=/workspaces/deepracer_ws/install/lib/python2.7/dist-packages:/workspaces/deepracer_ws/devel/lib/python2.7/dist-packages:$PYTHONPATH
ENV PKG_CONFIG_PATH=/workspaces/deepracer_ws/install/lib/pkgconfig:/workspaces/deepracer_ws/devel/lib/pkgconfig:$PKG_CONFIG_PATH
ENV CMAKE_PREFIX_PATH=/workspaces/deepracer_ws/install:/workspaces/deepracer_ws/devel:$CMAKE_PREFIX_PATH

CMD ["bash"]
