# Frigate NVR

## Planning

[CCTV Bandwidth and storage calculator](http://www.stardot.com/bandwidth-and-storage-calculator)

Cast of characters:

* nas to store the CCTV footage
* exi to run frigate
* HAOS VM to run home assistant

Steps:

* on NAS: create a dedicated `frigate` user and a ZFS dataset and expose it via
NFS
* on exi: create a dedicated `frigate` user, map local `/var/frigate` via NFS to
the NAS' frigate dataset
* on exi: run a frigate container, map container volume to NAS storage, e.t.c.
* integrate into home assistant

## Create NAS frigate User, Dataset and a Share

### Create frigate user

On NAS used GUI:

Param|Value
-----|-----
Username|frigate
Full Name|frigate nvr
UID|333
GUID|daemon
Password|Disabled
Home|/nonexistent

### Create frigate dataset

On NAS created a dataset.  The only overwrites:

Param|Value
-----|-----
Compression|off
Record size|1M
ACL Type|SMB/NFSv4
Quota|100GB
User|frigate
Group|daemon
Shared|via NFS

## Connect to NAS

### Create frigate user

Assuming docker is already installed on exi:
```sh
sudo useradd --uid 333 --comment "Frigate NVR" --groups docker --system \
    --home-dir /nonexistent --shell /usr/sbin/nologin \
    frigate
```

### Connect to the NAS share

On exi [mount](https://linux.die.net/man/8/mount) the share using NFS:

```sh
sudo mkdir /var/frigate
sudo mount -t nfs 192.168.10.30:/mnt/tank/frigate /var/frigate
```
To verify the success:
```
> mount
...
192.168.10.30:/mnt/tank/frigate on /var/frigate type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.10.50,local_lock=none,addr=192.168.10.30)
```
Also note the user who owns the local dir:
```
 > ls -la /var/frigate
total 5
drwxr-xr-x  2 frigate daemon    2 Dec 30 12:21 .
drwxr-xr-x 15 root    root   4096 Dec 30 13:12 ..
```

Once the changes are acceptable, update `/etc/fstab`
[with](https://linuxopsys.com/topics/linux-nfs-mount-entry-in-fstab-with-example):
```
92.168.10.30:/mnt/tank/frigate         /var/frigate      nfs4 rw,hard,intr,rsize=1048576,wsize=1048576,namlen=255,proto=tcp,timeo=20   0       0
```
then:
```sh
sudo umount /var/frigate
systemctl daemon-reload
sudo mount /var/frigate
```

Final verification:
```
> sudo -u frigate /usr/bin/bash
frigate@exi:/home/alex$ whoami
frigate
frigate@exi:/home/alex$ cd /var/frigate/
frigate@exi:/var/frigate$ ls -la
total 5
drwxr-xr-x  2 frigate daemon    2 Dec 30 12:21 .
drwxr-xr-x 15 root    root   4096 Dec 30 13:12 ..
frigate@exi:/var/frigate$ touch foo
frigate@exi:/var/frigate$ ls -la
total 5
drwxr-xr-x  2 frigate daemon    3 Dec 30 13:58 .
drwxr-xr-x 15 root    root   4096 Dec 30 13:12 ..
-rw-rw-r--  1 frigate daemon    0 Dec 30 13:58 foo
```


## Install

Sources:

* https://karlquinsland.com/frigate-install/

Created:

* [/etc/frigate/secrets](secrets)
* [/etc/frigate/config.yml](config.yml)
* [/etc/systemd/system/frigate.service](frigate.service)

Then:

```sh
sudo systemctl enable frigate
sudo systemctl start frigate
```
