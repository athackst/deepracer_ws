# aws_deepracer_ws

A VSCode workspace for the AWS DeepRacer.

## Setup

In VSCode, open this workspace in the included container.

Once the container has loaded, download the source code from a bash session inside the container.

```bash
wstool up -t src
```

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

1. Install [ROS Kinetic](http://wiki.ros.org/kinetic/Installation) (for compatibility with the AWS DeepRacer
2. Install dependencies

    ```bash
    ./install_depends.sh
    ```

3. Download the source code 
   
   ```bash
   wstool up -t src
   ```

4. Build the code
   
   ```bash
   catin_make
   ```