# Docker Cheat Sheet

## Install

From  https://www.linuxshelltips.com/install-docker-in-linux-mint/

```sh
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
   sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Identify the Ubuntu codename on which my Mint is based:
```
root@latitude7490:/tmp# cat /etc/os-release |grep -i ubuntu
ID_LIKE="ubuntu debian"
UBUNTU_CODENAME=jammy
```

In the following replace `jammy` with the relevant Ubuntu codename:
```sh
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Finally:
```sh
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## Verification

Verify the install with
[docker run](https://docs.docker.com/engine/reference/commandline/run/):
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
## Configuration

The location for client configuration files is determined by `DOCKER_CONFIG`
environment variable, seems to default to `$HOME/.docker`. More on docker
[environment variables](https://docs.docker.com/engine/reference/commandline/cli/#environment-variables).

[Configuration files](https://docs.docker.com/engine/reference/commandline/cli/#configuration-files)
include:

* config.json
* daemon.json

## Networking

[Reference](https://docs.docker.com/network/).

Show (standard) networks:

```console
root@suprox:~# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
6eef1bc6ffc5   bridge    bridge    local
35dbeb62ddb4   host      host      local
e023fada21bd   none      null      local
root@suprox:~# docker network inspect host
[
    {
        "Name": "host",
        "Id": "35dbeb62ddb42ebca3f5e2eae576921229b1279b496c387b78ef2c4ced5c70d8",
        "Created": "2023-02-10T18:31:29.131467146-08:00",
        "Scope": "local",
        "Driver": "host",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": []
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
```

Inspect the `bridge` network to see which containers are connected to it:
```
root@suprox:~# docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "6eef1bc6ffc530537c94652428cc80a295102845a84eb9ab18e40e8b6d666ee2",
        "Created": "2023-02-10T18:31:29.14533915-08:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "3dca544da1ce64d8c5a970b38a8ab340e958b86ee36bc2ee4aa0b44035ec21d0": {
                "Name": "mjpg-streamer",
                "EndpointID": "b1b45b71ba4df575fcbd35650902860691e6f9dbcc82d608e8f4b992322cbe42",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            },
            "bf42b1b5a4f78204a307323c514e22c402950f695e1d51e8c5df0c407dc66f98": {
                "Name": "portainer",
                "EndpointID": "617ed40e256b0a96dfbb5a74853dad400bc048797c11070735d4bb2b76787987",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```
## Example Use

### List images

```sh
docker image ls
```

More on
[docker image](https://docs.docker.com/engine/reference/commandline/image/).

### List containers

[docker container](https://docs.docker.com/engine/reference/commandline/container/).
List running:

```sh
docker container ls
```

Can also use
[docker ps](https://docs.docker.com/engine/reference/commandline/ps/).

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
### Kill all containers

Force delete all containers:

```sh
docker container rm -f $(docker container ls -aq)
```

### Inspect container

Inspecting container produces JSON:

```sh
sudo docker inspect _container_id_
```

Extract container environment and sort it.
```
sudo docker inspect _container_id_ | jq ".[0].Config.Env|sort[]"
```

### Get a Shell in a Container

```sh
docker container exec -it _container_id_or_name_ /bin/bash
```

Options used:

* `-i` - interactive
* `-t` - allocate a pseudo TTY device

## Observability

```
root@suprox:~# docker stats mjpg-streamer portainer
CONTAINER ID   NAME            CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O     PIDS
3dca544da1ce   mjpg-streamer   0.11%     1.75MiB / 31.26GiB    0.01%     7.12MB / 1.48GB   0B / 0B       4
bf42b1b5a4f7   portainer       0.00%     12.59MiB / 31.26GiB   0.04%     3.29MB / 8.37MB   0B / 25.4MB   7
^C
```
