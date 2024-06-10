# cron

[man cron](https://www.man7.org/linux/man-pages/man8/cron.8.html),
[man crontab](https://www.man7.org/linux/man-pages/man5/crontab.5.html),
[Understanding Crontab in Linux With Examples](https://linuxhandbook.com/crontab/).

Also relevant:
[man anacron](https://www.man7.org/linux/man-pages/man8/anacron.8.html),
[man anacrontab](https://www.man7.org/linux/man-pages/man8/anacron.8.html)

Also relevant [systemd timers](https://wiki.archlinux.org/title/Systemd/Timers)

## Logs

Because cron runs as a service:
```sh
journalctl -u cron
```

```sh
cat /var/log/syslog|grep cron
```

## Example

To shutdown at night `/etc/cron.d/good_night`:
```
#
# shutdown this machine at 0:55
#
50 0 * * * root /usr/sbin/shutdown +5
```

To cancel such shutdown just do:
```sh
sudo shutdown -c
```
