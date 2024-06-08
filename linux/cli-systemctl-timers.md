# systemctl timers

This is about working with
[systemd timers](https://wiki.archlinux.org/title/Systemd/Timers).

See also [other aspects of systemctl](cli-systemctl.html).

## List Timers

```sh
systemctl list-timers
```
produces:
```
alex@exi:~> systemctl list-timers
NEXT                             LEFT LAST                              PASSED UNIT                           ACTIVATES
Sat 2024-06-08 10:26:40 PDT     23min Sat 2024-06-08 09:52:44 PDT    10min ago fwupd-refresh.timer            fwupd-refresh.service
Sat 2024-06-08 10:33:15 PDT     30min Sat 2024-06-08 09:32:04 PDT    31min ago anacron.timer                  anacron.service
Sat 2024-06-08 21:48:31 PDT       11h Sat 2024-06-08 08:31:28 PDT 1h 31min ago motd-news.timer                motd-news.service
Sun 2024-06-09 00:00:00 PDT       13h Sat 2024-06-08 00:00:00 PDT      10h ago dpkg-db-backup.timer           dpkg-db-backup.service
Sun 2024-06-09 00:00:00 PDT       13h Sat 2024-06-08 00:00:00 PDT      10h ago logrotate.timer                logrotate.service
Sun 2024-06-09 00:12:38 PDT       14h Sat 2024-06-08 06:37:34 PDT 3h 25min ago apt-daily.timer                apt-daily.service
Sun 2024-06-09 03:10:53 PDT       17h Sun 2024-06-02 03:10:49 PDT            - e2scrub_all.timer              e2scrub_all.service
Sun 2024-06-09 06:40:14 PDT       20h Sat 2024-06-08 06:30:30 PDT 3h 32min ago apt-daily-upgrade.timer        apt-daily-upgrade.service
Sun 2024-06-09 08:26:34 PDT       22h Sat 2024-06-08 08:26:34 PDT 1h 36min ago update-notifier-download.timer update-notifier-download.service
Sun 2024-06-09 08:36:54 PDT       22h Sat 2024-06-08 08:36:54 PDT 1h 26min ago systemd-tmpfiles-clean.timer   systemd-tmpfiles-clean.service
Sun 2024-06-09 08:54:30 PDT       22h Sat 2024-06-08 08:35:17 PDT 1h 27min ago man-db.timer                   man-db.service
Sun 2024-06-09 10:53:10 PDT       24h Sat 2024-06-08 00:06:58 PDT       9h ago plocate-updatedb.timer         plocate-updatedb.service
Sun 2024-06-09 13:40:37 PDT  1 day 3h Mon 2024-06-03 04:43:14 PDT   5 days ago update-notifier-motd.timer     update-notifier-motd.service
Mon 2024-06-10 00:22:51 PDT 1 day 14h Mon 2024-06-03 00:12:48 PDT   5 days ago fstrim.timer                   fstrim.service
Mon 2024-06-10 07:14:07 PDT 1 day 21h Mon 2024-06-03 06:46:03 PDT   5 days ago apt-xapian-index.timer         apt-xapian-index.service

15 timers listed.
Pass --all to see loaded but inactive timers, too.
```
