# Old Kernels Cleanup

From the [forum
post](https://forum.proxmox.com/threads/clean-old-kernels.42040/#post-204417):

* Start with upgrading to the latest kernel `apt update && apt dist-upgrade` and
then rebooting.
* Learn the kernel version you are using `uname -a`.
* Show the kernels installed:  `dpkg --list|grep pve-kernel.*-pve`.
You only want to remove kernel packages of the form `pve-kernel-x.xx.xx-x-pve`!
* Do it with `apt purge pve-kernel-4.13.16-1-pve`.
* Observe the results with `ls -l /boot`
