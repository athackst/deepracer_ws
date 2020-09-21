FROM athackst/ros:kinetic-dev

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

COPY install_depends.sh /setup/install_depends.sh
RUN ./setup/install_depends.sh

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

CMD ["bash"]
