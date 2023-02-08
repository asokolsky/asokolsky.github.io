# `jourtnalctl` cheat sheet

[journalctl man page](https://www.man7.org/linux/man-pages/man1/journalctl.1.html):

## Configuration

```
/etc/systemd/journald.conf
```

## Show Service Log


```sh
journalctl --no-pager -u _service-name_
```
## Show events since the last boot

```sh
journalctl -b
```

## Show today events

```sh
journalctl --since=today
```

## Show (follow) current events

```sh
journalctl -f
```

## Control log size

Retain only the past two days:

```sh
journalctl --vacuum-time=2d
```

Retain only the past 500 MB:

```sh
journalctl --vacuum-size=500M
```
