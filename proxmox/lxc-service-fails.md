# Service Fails in an LXC

Observed:
```
root@unicon:~# systemctl list-units --state=failed
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
* sys-kernel-config.mount loaded failed failed Kernel Configuration File System

Legend: LOAD   -> Reflects whether the unit definition was properly loaded.
        ACTIVE -> The high-level unit activation state, i.e. generalization of SUB.
        SUB    -> The low-level unit activation state, values depend on unit type.

1 loaded units listed.

root@unicon:~# systemctl status sys-kernel-config.mount
x sys-kernel-config.mount - Kernel Configuration File System
     Loaded: loaded (/usr/lib/systemd/system/sys-kernel-config.mount; static)
     Active: failed (Result: exit-code) since Sat 2025-08-09 19:05:01 UTC; 8min ago
      Where: /sys/kernel/config
       What: configfs
       Docs: https://docs.kernel.org/filesystems/configfs.html
             https://www.freedesktop.org/wiki/Software/systemd/APIFileSystems
        CPU: 3ms

Aug 09 19:05:01 unicon mount[61]: mount: /sys/kernel/config: cannot mount configfs read-only.
Aug 09 19:05:01 unicon mount[61]:        dmesg(1) may have more information after failed mount system call.
Aug 09 19:05:01 unicon systemd[1]: sys-kernel-config.mount: Mount process exited, code=exited, status=32/n/a
Aug 09 19:05:01 unicon systemd[1]: sys-kernel-config.mount: Failed with result 'exit-code'.
Aug 09 19:05:01 unicon systemd[1]: Failed to mount sys-kernel-config.mount - Kernel Configuration File System.
Notice: journal has been rotated since unit was started, output may be incomplete.
```

Resolution from: https://www.enricobassetti.it/2023/05/proxmox-lxc-systemd-and-linux-capabilities/

Edit `/etc/pve/lxc/1003.conf` and add:
```
lxc.cap.drop: "sys_rawio"
```
Restart the LXC.
