#!/bin/bash

set -e

sudo apt-get update

# install system dependencies
sudo apt-get install -y jstest-gtk

# install ros packages
sudo apt-get install -y \
    ros-$ROS_DISTRO-joy \
    ros-$ROS_DISTRO-joy-teleop