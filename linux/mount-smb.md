# Mounting an SMB Share

Followed:

* [linux-mount-smb-share](https://www.linode.com/docs/guides/linux-mount-smb-share/);
* [mount-owner](https://www.baeldung.com/linux/mount-owner);
* [mount.cifs man page](https://linux.die.net/man/8/mount.cifs).

## Prerequisites

Verify components are installed:

```sh
mount -t cifs
fuser
```

## Prepare mount points

Create mount points:
```sh
mkdir ~/Movies
mkdir ~/Music
```

## Credentials

```
> ls -la ~/.nas-creds
-rw------- 1 alex alex 49 Dec 16 11:13 /home/alex/.nas-creds
> cat ~/.nas-creds
username=alex
password=********
domain=nass.lan
```

## Mount

```sh
> cat mount-nas.sh
mount -t cifs -o uid=alex,forceuid,gid=alex,forcegid,rw,credentials=/home/alex/.nas-creds \
    //192.168.10.30/movies /home/alex/Movies
mount -t cifs -o uid=alex,forceuid,gid=alex,forcegid,rw,credentials=/home/alex/.nas-creds \
    //192.168.10.30/music /home/alex/Music
```

## Unmount

```sh
sudo umount ~/Movies
```
