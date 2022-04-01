# systemctl

[systemctl](https://www.linux.org/docs/man1/systemctl.html) is a cli to
[systemd](https://www.linux.org/docs/man1/systemd.html).

## Start Service

Start x11vnc service:

```console
sudo systemctl start x11vnc.service
```
## Show Services

Show running services:

```console
systemctl list-units --type=service | grep running
```

## Show Service Status


```console
systemctl status Service
```
