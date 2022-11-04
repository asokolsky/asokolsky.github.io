# Docker Cheat Sheet

## Install

From  https://www.linuxshelltips.com/install-docker-in-linux-mint/

```sh
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

In the following replace `jammy` with parent Ubuntu version name:
```sh
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Finally:
```sh
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Verify the install:

```console
> docker --version
Docker version 20.10.21, build baeda1f

> sudo docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```


## List images

```sh
docker image ls
```

## List containers

List running:

```sh
docker container ls
```

List all containers, not only running, do not truncate output:

```sh
docker container ls -a --no-trunc
```

List IDs only:

```
docker container ls -q
1addfea727b3
09c4105cb356
443fc0c41710
b06cfe3053e5
4cf774b9e4a4
```
## Kill all containers

Force delete all containers:

```sh
docker container rm -f $(docker container ls -aq)
```

## Inspect container

Inspecting container produces JSON:

```sh
sudo docker inspect _container_id_
```

Extract container environment and sort it.
```
sudo docker inspect _container_id_ | jq ".[0].Config.Env|sort[]"
```
