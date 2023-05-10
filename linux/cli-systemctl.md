# systemctl

[systemctl](https://www.linux.org/docs/man1/systemctl.html) is a cli to
[systemd](https://www.linux.org/docs/man1/systemd.html).
Reasonable [intro](https://skyyy.hashnode.dev/systemctl-linux-command).

The pager defaults to `less`.  To disable it use `--no-pager` or
`export SYSTEMD_PAGER=`.

[How to manage systemd units with systemctl](https://www.2daygeek.com/linux-systemctl-command-manage-systemd-units-service/)


## Unit Types

To list the unit (daemon) types:

```
$ systemctl -t help
Available unit types:
service
mount
swap
socket
target
device
automount
timer
path
slice
scope
```

Unit Type|File Extension|Description
---------|--------------|-----------
Device|.device|A device file recognized by the kernel.
Mount|.mount|A file system mount point.
Service|.service|A service on the system, including instructions for starting, restarting, and stopping the service.
Socket|.socket|A network socket associated with a service.
Swap|.swap|A swap device or a swap file.
Target|.target|It replaces sysV init run levels that control system boot.
Timer|.timer|A systemd timer.


## Types of Daemons

There are 3 types of daemons:

* services
* sockets
* paths

To see the system's processes in each:

```sh
systemctl
systemctl list-units --type service
systemctl list-units --type=service
systemctl list-units --type=socket --state=LOAD
systemctl list-units --type=path --all
systemctl list-unit-files
```
e.g.

```sh
systemctl
```

Also check out:
```
systemctl list-unit-files
```

[Working with Services](cli-systemctl-services.html)

[Working with Sockets](cli-systemctl-sockets.html)

[Working with Mounts](cli-systemctl-mounts.html)

[Working with Targets](cli-systemctl-targets.html)

[Working with Timers](cli-systemctl-timers.html)
