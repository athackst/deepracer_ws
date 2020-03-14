#
# Build the ros2 messages
# ------------------------
FROM athackst/ros2:eloquent-dev as ros2_builder

WORKDIR /workspaces/ros2

RUN mkdir -p src && cd src \
 && git clone --branch eloquent https://github.com/athackst/aws_deepracer_msgs.git \
 && cd ../ \
 && colcon build --merge-install --install-base /opt/ros/eloquent

#
# Make the ros2 deepracer image
# ------------------------
FROM athackst/ros2:eloquent-base as ros2

# Get the ros2 messages
COPY --from=ros2_builder /opt/ros/eloquent/ /opt/ros/eloquent

CMD ["bash"]