# aws_deepracer_ws

A VSCode workspace for the AWS DeepRacer.

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

## Run

Run the code inside the docker container

1. Create a deployment image

    ```bash
    docker build -f .deploycontainer/Dockerfile . -t localhost:5000/deepracer_ws
    ```

2. Run the docker image with the launch file.

    ```bash
    docker run -it --network=host --privileged -e ROS_MASTER_URI=http://$DEEPRACER_IP:11311 localhost:5000/deepracer_ws roslaunch deepracer_joy deepracer_joy.launch
    ```

    You will need to run the container attached to the host network, with elevated privileges (for the input device), and with the ROS_MASTER_URI set to the IP address of your DeepRacer.

## Deploy

Once you've created your container, you can optionally load it onto your DeepRacer.  This is most easily done by setting up a local docker registry and pulling the image onto the DeepRacer from it.

1. Start a local docker registry

    ```bash
    docker run -d -p 5000:5000 --restart always --name registry registry:2
    ```

2. Push your image to the registry

    ```bash
    docker push localhost:5000/deepracer_ws
    ```

3. Set up your deepracer with [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
   Be sure to add the `deepracer` user to the `docker` group

4. Add your host to `/etc/docker/daemon.json`

    ```json
    { "insecure-registries":["your_hostname.local:5000"] }
    ```

    Where `your_hostname` is the hostname of the computer running the docker registry.

    This will let you connect to your local docker registry with an unsecured connection.

5. Pull the image

   ```bash
   docker pull your_hostname.local:5000/deepracer_ws
   ```

6. Run the image.

    Run the image the same way you did on the remote machine

    ```bash
    docker run -it --network=host --privileged -e ROS_MASTER_URI=http://localhost:11311 your_hostname.local:5000/deepracer_ws roslaunch deepracer_joy deepracer_joy.launch
    ```
