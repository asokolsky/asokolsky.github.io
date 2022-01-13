# Sharing Files in ProxMox

## Sources

https://forum.proxmox.com/threads/step-by-step-install-w-efi-zfs-ssd-cache-file-server.41619/

## Proxmox Storage Config

I have:

```
root@fuji:~# zpool list -v
NAME        SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
tank        464G   688K   464G        -         -     0%     0%  1.00x    ONLINE  -
  sda1      464G   688K   464G        -         -     0%  0.00%      -  ONLINE
root@fuji:~# mount|grep tank
tank on /tank type zfs (rw,xattr,noacl)
```

## Get Container Template

I downloaded debian-10-turnkey-fileserver_16.1-1_amd64.tar.gz from 
http://mirror.turnkeylinux.org/turnkeylinux/images/proxmox/

## Create Container

Choose name, password, RAM: 512M, Cores: 2, Storage: 8GB, IP address: DHCP, mount turnkey-linux-fileserver.

Do not start it yet.

## Configure Container in ProxMox

Start at boot: Yes.

Resources\Mount point (mp0): /tank, mp=/mnt/media,mountoptions=noatime

or edit /etc/pve/lxc/<containerID>.conf

mp0:/tank,mp=/mnt/media

## Configure Container in GUI

Start the container. I ssh'ed as root.

WebDAV (CGI):    https://192.168.10.143
Web shell:       https://192.168.10.143:12320
Webmin:          https://192.168.10.143:12321
SMB/CIFS:        \\192.168.10.143 (ports 139/445)
SSH/SFTP:        root@192.168.10.143 (port 22)


