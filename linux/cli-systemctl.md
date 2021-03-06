# systemctl

[systemctl](https://www.linux.org/docs/man1/systemctl.html) is a cli to
[systemd](https://www.linux.org/docs/man1/systemd.html).

The pager defaults to `less`.  To disable it use `--no-pager` or
`export SYSTEMD_PAGER=`.

# Types of Daemons

To list the types of daemons:

```sh
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

There are 3 types of daemons:

* services
* sockets
* paths

To see the system's processes in each:

```sh
$ systemctl
$ systemctl list-units --type=service
$ systemctl list-units --type=socket --state=LOAD
$ systemctl list-units --type=path --all
$ systemctl list-unit-files
```

## Start Service

Start x11vnc service:

```sh
sudo systemctl start x11vnc.service
```
## Show Services

Show running services:

```sh
systemctl list-units --type=service | grep running
```

## Show Service Status


```sh
systemctl status Service
```
