# aws_deepracer_ws/ros1_bridge_ws

## Purpose

To provide a bridge between the native [ros kinetic](http://wiki.ros.org/kinetic) interface on the [AWS DeepRacer](https://aws.amazon.com/deepracer/) and [ros2 eloquent](https://index.ros.org/doc/ros2/Releases/Release-Eloquent-Elusor/)

## Getting started

A step-by-step installation and usage guide is available [on my blog](http://www.lyonthackston.com/articles/5_aws_deepracer_ros2_bridge.html).

### Prerequisites

* [Docker CE](http://dockerdocs.gclearning.cn/install/)

### Building

```bash
docker build -t deepracer_ros1bridge -f Dockerfile ../
```
