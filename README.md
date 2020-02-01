# aws_deepracer_ws

Workspaces to develop software for the [AWS DeepRacer](https://aws.amazon.com/deepracer/).

## Purpose

This repository is split between 3 main work environments.

* ros_ws: The environment for the native [ros kinetic](http://wiki.ros.org/kinetic) environment of the DeepRacer
* ros1_bridge_ws: A bridged workspace between ros1 and [ros2 eloquent](https://index.ros.org/doc/ros2/Releases/Release-Eloquent-Elusor/)
* ros2_ws: A workspace for a [ros2 eloquent](https://index.ros.org/doc/ros2/Releases/Release-Eloquent-Elusor/) workspace for the Deepracer

## Getting Started

This repository makes use of [git sub-modules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to retrieve the appropriate versions of code for the respective environments.

```bash
git clone --recurse-submodules git@github.com:athackst/deepracer_ws.git
```

To make the most of this workspace, you should also have [Docker CE](http://dockerdocs.gclearning.cn/install/) and [Visual Studio Code](https://code.visualstudio.com/) installed.

See [my articles](http://www.lyonthackston.com/thoughts.html) for more information and detailed instructions.
