# aws_deepracer_ws

A development workspace for the AWS DeepRacer.

## Setup

Get the code.

```bash
git clone --recurse-submodules git@github.com:athackst/deepracer_ws.git
```

## Building

### VS Code

In VSCode, open this workspace in the included container.

You can build the code in one of two ways; using the integrated terminal, or using a pre-defined task.

#### Terminal

```bash
catkin_make install
```

#### Task

Alternatively, you can use one of the pre-configured vscode tasks to build and debug your code

Terminal->Run Task

* build : default development build
* build (debug) : build with debug output
* install : default development install

### Local

If you'd prefer to run natively instead of in the provided container

1. Install [ROS Kinetic](http://wiki.ros.org/kinetic/Installation) (for compatibility with the AWS DeepRacer)
2. Install dependencies

    ```bash
    ./install_depends.sh
    ```

3. Download the source code.

   ```bash
   wstool up -t src
   ```

4. Build the code

   ```bash
   catkin_make install
   ```

## deepracer_joy

Make a docker container for controlling the deepracer with a gamepad/joystick

1. Create the docker image

    ```bash
    docker build -f deepracer_joy.dockerfile . -t localhost:5000/deepracer_joy
    ```

2. Run the docker image with the launch file.

    ```bash
    docker run -it --network=host --privileged -e ROS_MASTER_URI=http://$DEEPRACER_IP:11311 localhost:5000/deepracer_joy roslaunch deepracer_joy deepracer_joy.launch
    ```

    You will need to run the container attached to the host network, with elevated privileges (for the input device), and with the ROS_MASTER_URI set to the IP address of your DeepRacer.

See my articles on [controlling the deepracer with a gamepad](http://lyonthackston.com/articles/3_deepracer_joy.html) and [running the deepracer_joy container onboard](http://lyonthackston.com/articles/4_deepracer_joy_onboard.html) for more information.
