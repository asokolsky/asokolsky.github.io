# systemctl targets

This is about working with targets.
[Other aspects of systemctl](cli-systemctl.html).


## List Targets


```sh
systemctl list-units --type=target
```
or
```sh
systemctl list-unit-files --type=target
```

## Display the default target

By default, the `systemd` process uses the default target when booting the
system. To view the default target on your system:

```sh
systemctl get-default
```

To set a different target as a default target, e.g. `graphical.target`:

```sh
sudo systemctl set-default graphical.target
```

## Change the current active target

To change the current active target immediately, e.g. to switch from the
current graphical target (GUI) to the multi-user target (CLI):

```sh
sudo systemctl isolate multi-user.target
```

## Boot the system in Single User mode

If your system unable to complete a regular boot, you can boot it into the
rescue (single-user) mode for further troubleshooting.

```sh
sudo systemctl rescue
```

In rescue mode the system tries to mount all the local file systems and start
only few important system services, but it does not activate network interfaces
or allow more users to log into the system at the same time.


## Boot the system in Emergency mode

If the Rescue/Single User mode does not boot, try Emergency mode.

In emergency mode, the system mounts the root file system for read-only purposes
and does not attempt to load any other local file systems. Network interfaces
are not activated.  Only essential services are started.

```sh
sudo systemctl emergency
```

## Power management

systemctl also allows users to `halt`, `shutdown` and `reboot` a system.

```sh
sudo systemctl halt
```
```sh
sudo systemctl poweroff
```
```sh
$ sudo systemctl reboot
```
