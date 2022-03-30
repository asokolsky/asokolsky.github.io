# Useful Linux Commands

## Process Command Line

```
cat /proc/_pid_/cmdline |xargs -0 echo
```

## netstat

[netstat](https://www.linux.org/docs/man8/netstat.html) prints network
connections, etc.

```console
sudo netstat -plutn
```

## du

[du](https://www.linux.org/docs/man1/du.html) estimates file space usage.

Show how much space is used by directories in this folder:

```console
du -sh -- *
```

## systemctl

[systemctl](https://www.linux.org/docs/man1/systemctl.html) is a cli to
[systemd](https://www.linux.org/docs/man1/systemd.html).

Start x11vnc service:

```console
sudo systemctl start x11vnc.service
```

Show running services:

```console
systemctl list-units --type=service | grep running
```

Show ntpdate service status

```console
systemctl status ntpdate.service
```
