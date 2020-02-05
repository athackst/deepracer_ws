# aws_deepracer_ws

A VSCode workspace for the AWS DeepRacer.

## Setup

Get the code.

```bash
git clone --recurse-submodules git@github.com:athackst/deepracer_ws.git
```

In VSCode, open this workspace in the included container.

## Building

You can build the code in one of two ways; using the integrated terminal, or using a pre-defined task.

### Terminal

```bash
catkin_make
```

### Task

Alternatively, you can use one of the pre-configured vscode tasks to build and debug your code

Terminal->Run Task

* build : default development build
* build (debug) : build with debug output
* install : default development install

## Local setup

If you'd prefer to run natively instead of in the provided container

1. Install [ROS Kinetic](http://wiki.ros.org/kinetic/Installation) (for compatibility with the AWS DeepRacer)

2. Install dependencies

    ```bash
    ./install_depends.sh
    ```

3. Build the code

   ```bash
   catkin_make
   ```
