# Useful Linux Commands

## netstat

[netstat](https://www.linux.org/docs/man8/netstat.html) prints network
connections, etc.

```
sudo netstat -plutn
```

## du

[du](https://www.linux.org/docs/man1/du.html) estimates file space usage.

Show how much space is used by directories in this folder:

```
du -sh -- *
```

## systemctl

[systemctl](https://www.linux.org/docs/man1/systemctl.html) is a cli to
[systemd](https://www.linux.org/docs/man1/systemd.html).

Restart x11vnc service:

```
sudo systemctl start x11vnc.service
```

Show running services:

```
systemctl list-units --type=service | grep running
```

Show ntpdate service status

```
systemctl status ntpdate.service
```
