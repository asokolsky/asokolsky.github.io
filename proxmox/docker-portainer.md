# Running Docker with Portainer on Proxmox

The plan is to have Portainer to manage docker containers.  For that to happen:

* run docker on Proxmox itself, i.e. not inside a VM or LXC container,
* run Portainer in a docker container

## Docker Installation

Following steps from
https://docs.docker.com/engine/install/debian/#install-using-the-repository:

```sh
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Then:

```sh
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

To verify the install:
```
docker run hello-world
```
and

```
root@duo:~# systemctl status containerd
● containerd.service - containerd container runtime
     Loaded: loaded (/lib/systemd/system/containerd.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-01-28 10:02:32 PST; 43min ago
       Docs: https://containerd.io
   Main PID: 780428 (containerd)
      Tasks: 23
     Memory: 17.8M
        CPU: 11.044s
     CGroup: /system.slice/containerd.service
             ├─780428 /usr/bin/containerd
             └─784004 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 16d83c1e96548bbb12f1df2a34128a2958b8fbbefefd41efadc16b126beca9ce -address /run/containerd/containerd.sock
```

## Portainer Installation

Following steps from
https://docs.portainer.io/start/install/server/docker/linux:

```sh
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce:latest
```

Verify:
```
root@duo:~# docker ps
CONTAINER ID   IMAGE                           COMMAND        CREATED         STATUS         PORTS                                                      NAMES
16d83c1e9654   portainer/portainer-ce:latest   "/portainer"   4 seconds ago   Up 3 seconds   0.0.0.0:8000->8000/tcp, 0.0.0.0:9443->9443/tcp, 9000/tcp   portainer
```

Then just point browser to https://duo:9443/

To verify:
```
root@duo:~# systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2023-01-28 10:02:33 PST; 46min ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 780566 (dockerd)
      Tasks: 29
     Memory: 311.4M
        CPU: 10.142s
     CGroup: /system.slice/docker.service
             ├─780566 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
             ├─783975 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9443 -container-ip 172.17.0.2 -container-port 9443
             └─783989 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8000 -container-ip 172.17.0.2 -container-port 8000
```
