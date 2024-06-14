# Portainer

I use portainer to run docker images.

See also other [portainer on Proxmox notes](/proxmox/portainer.html)

## Install

To install portainer on ubuntu I followed
[instructions](https://docs.portainer.io/start/install-ce/server/docker/linux),
as root:
```sh
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data \
    portainer/portainer-ce:latest
```

The GUI is now available at [https://exi:9443](https://exi:9443).

## Upgrade

```sh
docker stop portainer
docker rm portainer
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data \
    portainer/portainer-ce:latest
```