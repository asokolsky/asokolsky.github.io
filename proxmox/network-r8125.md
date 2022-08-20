# Support for RTL8125

NIC is detected:

```
root@pmox3:~# lspci
...
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7) I219-LM (rev 10)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
```

By default r8169 is used:

```
root@pmox3:~# ethtool -i enp1s0
driver: r8169
version: 5.15.39-3-pve
firmware-version:
expansion-rom-version:
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: yes
supports-priv-flags: no
root@pmox3:~# dmesg | grep r8169
[    1.741841] r8169 0000:01:00.0: enabling device (0100 -> 0103)
[    1.756924] r8169 0000:01:00.0 eth0: RTL8125B, 1c:fd:08:75:10:34, XID 641, IRQ 126
[    1.756941] r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    1.806336] r8169 0000:01:00.0 enp1s0: renamed from eth0
```

Yet:
```
root@pmox3:~# ethtool enp1s0
netlink error: failed to retrieve link settings
netlink error: No such device
netlink error: failed to retrieve link settings
netlink error: No such device
Settings for enp1s0:
        Supports Wake-on: pumbg
        Wake-on: d
        Link detected: no
```

## Attempt to blacklist r8169

Let's try to replace the driver:
```
root@pmox3:~# cat /etc/modprobe.d/pve-blacklist.conf
# This file contains a list of modules which are not supported by Proxmox VE

# nidiafb see bugreport https://bugzilla.proxmox.com/show_bug.cgi?id=701
blacklist nvidiafb

# force use of alternative driver
blacklist r8169
```

Do not forget:

```
root@pmox3:~# update-initramfs -u
update-initramfs: Generating /boot/initrd.img-5.15.39-3-pve
Running hook script 'zz-proxmox-boot'..
Re-executing '/etc/kernel/postinst.d/zz-proxmox-boot' in new private mount namespace..
No /etc/kernel/proxmox-boot-uuids found, skipping ESP sync.
```

## Install r8125-dkms

Follow instructions
[r8125-dkms on GitHub](https://github.com/awesometic/realtek-r8125-dkms).

On [releases page](https://github.com/awesometic/realtek-r8125-dkms/releases)
get the link to the latest deb package, e.g.
https://github.com/awesometic/realtek-r8125-dkms/releases/download/9.009.02-1/realtek-r8125-dkms_9.009.02-1_amd64.deb

Get the deb file:

```
root@pmox3:~# wget https://github.com/awesometic/realtek-r8125-dkms/releases/download/9.009.02-1/realtek-r8125-dkms_9.009.02-1_amd64.deb
```

Fix broken stuff:

```
root@pmox3:~/r8125-9.009.02# apt --fix-broken install
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
```

Install the driver:

```
root@pmox3:~# dpkg -i realtek-r8125-dkms_9.009.02-1_amd64.deb
(Reading database ... 89325 files and directories currently installed.)
Preparing to unpack realtek-r8125-dkms_9.009.02-1_amd64.deb ...

------------------------------
Deleting module version: 9.009.02
completely from the DKMS tree.
------------------------------
Done.
Unpacking realtek-r8125-dkms (9.009.02-1) over (9.009.02-1) ...
Setting up realtek-r8125-dkms (9.009.02-1) ...
Loading new realtek-r8125-9.009.02 DKMS files...
Building for 5.15.39-3-pve
Building for architecture amd64
Module build for kernel 5.15.39-3-pve was skipped since the
kernel headers for this kernel does not seem to be installed.
```

Install missing components:

```
root@pmox3:~# apt-get install build-essential linux-headers-$(uname -r)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Note, selecting 'linux-headers-5.15.39-3-pve-amd64' for regex 'linux-headers-5.15.39-3-pve'
Note, selecting 'pve-headers-5.15.39-3-pve' instead of 'linux-headers-5.15.39-3-pve-amd64'
build-essential is already the newest version (12.9).
build-essential set to manually installed.
The following NEW packages will be installed:
  pve-headers-5.15.39-3-pve
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 12.5 MB of archives.
After this operation, 86.7 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://download.proxmox.com/debian/pve bullseye/pve-no-subscription amd64 pve-headers-5.15.39-3-pve amd64 5.15.39-3 [12.5 MB]
Fetched 12.5 MB in 5s (2,592 kB/s)
Selecting previously unselected package pve-headers-5.15.39-3-pve.
(Reading database ... 89325 files and directories currently installed.)
Preparing to unpack .../pve-headers-5.15.39-3-pve_5.15.39-3_amd64.deb ...
Unpacking pve-headers-5.15.39-3-pve (5.15.39-3) ...
Setting up pve-headers-5.15.39-3-pve (5.15.39-3) ...
```

Successful build:

```
root@pmox3:~# dpkg -i realtek-r8125-dkms_9.009.02-1_amd64.deb
(Reading database ... 113040 files and directories currently installed.)
Preparing to unpack realtek-r8125-dkms_9.009.02-1_amd64.deb ...

------------------------------
Deleting module version: 9.009.02
completely from the DKMS tree.
------------------------------
Done.
Unpacking realtek-r8125-dkms (9.009.02-1) over (9.009.02-1) ...
Setting up realtek-r8125-dkms (9.009.02-1) ...
Loading new realtek-r8125-9.009.02 DKMS files...
Building for 5.15.39-3-pve
Building for architecture amd64
Building initial module for 5.15.39-3-pve
Done.

r8125.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/5.15.39-3-pve/updates/dkms/

depmod....

DKMS: install completed.
root@pmox3:~# ls -la /lib/modules/5.15.39-3-pve/updates/dkms/
total 320
drwxr-xr-x 2 root root     22 Aug 19 15:32 .
drwxr-xr-x 3 root root     18 Aug 19 15:32 ..
-rw-r--r-- 1 root root 324872 Aug 19 15:32 r8125.ko
```

Finally:

```
root@pmox3:~# dmesg |grep -i r8125
[    4.236635] r8125 2.5Gigabit Ethernet driver 9.009.02-NAPI loaded
[    4.236660] r8125 0000:01:00.0: enabling device (0100 -> 0103)
[    4.281779] r8125: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.
[    4.283945] r8125  Copyright (C) 2022 Realtek NIC software team <nicfae@realtek.com>
[    4.397780] r8125 0000:01:00.0 enp1s0: renamed from eth0
root@pmox3:~#
root@pmox3:~# ethtool enp1s0
Settings for enp1s0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: Unknown
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000033 (51)
                               drv probe ifdown ifup
        Link detected: no
```
