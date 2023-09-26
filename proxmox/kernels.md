# Old Kernels Cleanup

## pve-kernel

From the [forum
post](https://forum.proxmox.com/threads/clean-old-kernels.42040/#post-204417):

* Start with upgrading to the latest kernel `apt update && apt dist-upgrade` and
then rebooting.
* Learn the kernel version you are using `uname -a`.
* Show the kernels installed:  `dpkg --list|grep proxmox-kernel.*-pve`.
You only want to remove kernel packages of the form `proxmox-kernel-x.xx.xx-x-pve`!
* Do it with `apt purge proxmox-kernel-6.2.16-8-pve`.
* Observe the results with `ls -l /boot`

## linux-image

Somehow linux-image packages made it into my proxmox install:

```
root@duo:/# dpkg --list|grep pve-kernel.*-pve
ii  pve-kernel-5.15.30-2-pve             5.15.30-3                              amd64        The Proxmox PVE Kernel Image
ii  pve-kernel-5.15.35-1-pve             5.15.35-2                              amd64        The Proxmox PVE Kernel Image
root@duo:/# uname -a
Linux duo 5.15.30-2-pve #1 SMP PVE 5.15.30-3 (Fri, 22 Apr 2022 18:08:27 +0200) x86_64 GNU/Linux
root@duo:/# dpkg -l|grep linux-image
linux-image-5.10.0-10-amd64
linux-image-5.10.0-11-amd64
linux-image-5.10.0-12-amd64
linux-image-5.10.0-13-amd64
linux-image-5.10.0-14-amd64
linux-image-5.10.0-8-amd64
linux-image-5.10.0-9-amd64
linux-image-amd64
root@duo:/# uname -a
Linux duo 5.15.30-2-pve #1 SMP PVE 5.15.30-3 (Fri, 22 Apr 2022 18:08:27 +0200) x86_64 GNU/Linux
```

In this case:

```sh
apt purge linux-image-5.10.0-14-amd64
update-grub2
```

## More

https://github.com/tteck/Proxmox/blob/main/misc/kernel-clean.sh
