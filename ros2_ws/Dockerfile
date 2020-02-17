# Build the workspace
FROM athackst/ros2:eloquent-dev as builder

COPY src/ /workspaces/ros2/src/

WORKDIR /workspaces/ros2
RUN colcon build --merge-install --install-base /opt/ros/eloquent

# Deploy the workspace
FROM athackst/ros2:eloquent-base

COPY --from=builder /opt/ros/eloquent /opt/ros/eloquent

CMD ["bash"]