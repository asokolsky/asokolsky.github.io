# Install Samba Server on Ubuntu

Sources:

* https://ubuntu.com/tutorials/install-and-configure-samba
* https://phoenixnap.com/kb/ubuntu-samba

## Install

```sh
sudo apt update
sudo apt upgrade
sudo  apt install samba -y
```

To make it "discoverable":

```sh
sudo apt install wsdd, avahi-daemon
```

Verify install:
```
# samba -V
Version 4.18.6-Ubuntu

# systemctl status smbd
● smbd.service - Samba SMB Daemon
     Loaded: loaded (/lib/systemd/system/smbd.service; enabled; preset: enabled)
     Active: active (running) since Fri 2024-01-12 08:38:35 PST; 1min 10s ago
       Docs: man:smbd(8)
             man:samba(7)
             man:smb.conf(5)
    Process: 956249 ExecCondition=/usr/share/samba/is-configured smb (code=exited, status=0/SUCCESS)
    Process: 956259 ExecStartPre=/usr/share/samba/update-apparmor-samba-profile (code=exited, status=0/SUCCESS)
   Main PID: 956270 (smbd)
     Status: "smbd: ready to serve connections..."
      Tasks: 3 (limit: 18711)
     Memory: 11.3M
        CPU: 59ms
     CGroup: /system.slice/smbd.service
             ├─956270 /usr/sbin/smbd --foreground --no-process-group
             ├─956272 "smbd: notifyd" .
             └─956273 "smbd: cleanupd "

Jan 12 08:38:35 exi systemd[1]: Starting smbd.service - Samba SMB Daemon...
Jan 12 08:38:35 exi update-apparmor-samba-profile[956264]: grep: /etc/apparmor.d/samba/smbd-shares: No such file or directory
Jan 12 08:38:35 exi update-apparmor-samba-profile[956267]: diff: /etc/apparmor.d/samba/smbd-shares: No such file or directory
Jan 12 08:38:35 exi systemd[1]: Started smbd.service - Samba SMB Daemon.
```

## Config

Identify shares to share:

```
root@exi:~# ls -la /mnt/btr/foo/
total 2
drwxr-xr-x 2 root root   3 Jan 13 09:19 .
drwxr-xr-x 3 root root   3 Jan 13 09:11 ..
-rw-r--r-- 1 root root 511 Jan 13 09:19 history
root@exi:~# ls -la /mnt/tank/bar/
total 2
drwxr-xr-x 2 root root   3 Jan 13 09:20 .
drwxr-xr-x 3 root root   4 Jan 13 09:14 ..
-rw-r--r-- 1 root root 286 Jan 13 09:20 history
```

In `/etc/samba/smb.conf` modify:

```
interfaces = lo enp4s0
bind interfaces only = yes

[btr]
comment = btr samba share
path = /mnt/btr
read only = no
writable = yes
browseable = yes
guest ok = yes
valid users = @alex

[tank]
comment = tank samba share
path = /mnt/tank
read only = no
writable = yes
browseable = yes
guest ok = yes
valid users = @alex
```

Add samba user:

```
# sudo smbpasswd -a alex
New SMB password:
Retype new SMB password:
Added user alex.
```
### Change file owner/permissions

To grant read/write/execute permissions to the sharing directory, run setfacl:
```sh
setfacl -R -m "u:alex:rwx" /mnt/btr/foo
```

```
# setfacl -R -m "u:alex:rwx" /mnt/btr/foo
setfacl: /mnt/btr/foo: Operation not supported
setfacl: /mnt/btr/foo/history: Operation not supported
```

Instead:
```sh
chown -R alex:users /mnt/btr/foo/
chown -R alex:users /mnt/tank/bar/
```
