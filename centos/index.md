# Customizing CENTOS Install

## Hostname
```
[alex@localhost ~]$ sudo hostnamectl
   Static hostname: localhost.localdomain
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 18e2b166881a4ccba32acabd8ecd37c3
           Boot ID: 67a2d29b9e0f4b8fb4f8a920129e7d6b
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-1127.19.1.el7.x86_64
      Architecture: x86-64
[alex@localhost ~]$ sudo hostnamectl set-hostname centos7
[alex@localhost ~]$ sudo hostnamectl
   Static hostname: centos7
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 18e2b166881a4ccba32acabd8ecd37c3
           Boot ID: 67a2d29b9e0f4b8fb4f8a920129e7d6b
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-1127.19.1.el7.x86_64
      Architecture: x86-64
[alex@localhost ~]$
```

## Update the Install

```
sudo yum update
sudo yum upgrade
```
## Add EPEL repo

Add EPEL repo:

```
sudo yum -y install epel-release
sudo yum repolist
```

## Install Favorite Packages

### nettools

For things like netstat:

```
yum install net-tools
```

### Emacs

```
sudo yum install emacs
```

### HTOP

```
sudo yum search htop
sudo yum install htop
```

htop keyboard commands: s, l, H

https://www.cyberciti.biz/faq/how-to-install-htop-on-centos-linux-8/

### Gnome Tweaks

In GUI:
Software \ Search tweaks \ GNOME Tweaks \ Install

In CLI:

```
sudo yum install gnome-tweak-tool
```
More: https://linuxhint.com/tweaking_gnome_desktop_centos8/

## Services

In general to start/stop :
https://ma.ttias.be/start-or-stop-a-service-on-centos-7/

### Firewall

```
[alex@centos7 ~]$ sudo firewall-cmd --state
[sudo] password for alex:
running
[alex@centos7 ~]$
[alex@centos7 ~]$ sudo systemctl stop firewalld
```
If you are really sure:
```
[alex@centos7 ~]$ sudo systemctl disable firewalld
Removed symlink /etc/systemd/system/multi-user.target.wants/firewalld.service.
Removed symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.
```

### Qemu Guest Package

If this is a VM, follow through on this: https://pve.proxmox.com/wiki/Qemu-guest-agent

```
[alex@localhost tmp]$ sudo yum install qemu-guest-agent
[sudo] password for alex:
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: repo.miserver.it.umich.edu
 * epel: packages.oit.ncsu.edu
 * extras: mirror.netdepot.com
 * updates: mirror.siena.edu
Resolving Dependencies
--> Running transaction check
---> Package qemu-guest-agent.x86_64 10:2.12.0-3.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

============================================================================================================================
 Package                            Arch                     Version                           Repository              Size
============================================================================================================================
Installing:
 qemu-guest-agent                   x86_64                   10:2.12.0-3.el7                   base                   116 k

Transaction Summary
============================================================================================================================
Install  1 Package

Total download size: 116 k
Installed size: 297 k
Is this ok [y/d/N]: y
Downloading packages:
qemu-guest-agent-2.12.0-3.el7.x86_64.rpm                                                             | 116 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 10:qemu-guest-agent-2.12.0-3.el7.x86_64                                                                  1/1
  Verifying  : 10:qemu-guest-agent-2.12.0-3.el7.x86_64                                                                  1/1

Installed:
  qemu-guest-agent.x86_64 10:2.12.0-3.el7

Complete!

```

But then

```
[alex@localhost tmp]$ sudo systemctl start qemu-guest-agent
A dependency job for qemu-guest-agent.service failed. See 'journalctl -xe' for details.
```

Resolved by VM reboot.

## Install More Fonts

```
yum install fontconfig
yum install freetype*
yum install urw-fonts
```

## Customize Keyboard: Swap CapsLock & Ctrl

In Tweaks: Keyabord & Mouse\ Ctrl Position \ Swap Ctrl & CapsLock

Alternatively:
```
/usr/bin/setxkbmap -option "ctrl:nocaps"
```
More: http://www.noah.org/wiki/CapsLock_Remap_Howto

## Java Tuning

It's all about GC. At least Java 7 update 51.

Choose Garbage First (G1) Collector

* set the heap size;
* set target GC pause time.

https://youtu.be/7dkSze52i-o?t=1771
