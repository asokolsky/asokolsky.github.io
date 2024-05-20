# Docker Storage

After install of docker in `/var/lib/docker`:

- aufs
- containers
- image
- volumes

## Volume vs Bind Mounting

Volume mount:

```sh
# this creates /var/lib/docker/volumes/data_volume
docker volume create data_volume
docker run -v data_volume:/var/lib/mysql mysql
```

Bind mount:
```sh
# this binds the existing directory
docker run -v /data/mysql:/var/lib/mysql mysql
```
better yet:
```sh
docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
```

## Storage Drivers

Manage storage on images and containers.

* aufs
* zfs
* btrfs
* Device Mapper
* Overlay
* Overlay2

These do NOT manage volumes

## Volume Driver Plugins

- local
- azure FS
- Convoy
- GlusterFS
- rexray/ebs for AWS
