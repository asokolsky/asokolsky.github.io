# log

This replaces [syslog](cli-syslog.html).  There is also `dmesg`.

https://eclecticlight.co/2016/10/01/using-the-logs-in-sierra-some-practical-tips/

```sh
log help
```


```
log show --predicate [] --style syslog --start [] --end [] --info --last []
```

Suggested command to inspect log entries for Time Machine backups:
```sh
log show --predicate 'subsystem == "com.apple.TimeMachine"' --info | grep 'upd: (' | cut -c 1-19,140-999
```

If you want to look in detail at a relatively short section of log, use
```sh
log show --style syslog --start '2016-09-30 06:58:10' --end '2016-09-30 06:59:00' --info
```

To capture errors over the last minute:
```sh
log show --predicate 'messageType == error' --style syslog --info --last 1m | cut -c 1-22,43-999
```


```sh
log show --start '2016-09-30 06:58:10' --end '2016-09-30 06:59:50' --info > ~/Documents/logrestart.text
```

To look for a startup entry:
```sh
log show --predicate 'eventMessage contains "BOOT_TIME"' --style syslog --info | cut -c 1-22,43-999
```

To look for a system waking up:
```sh
log show --predicate 'eventMessage contains "System Wake"' --style syslog --info | cut -c 1-22,43-999
```

To look for error messages from an app, you will need to discover that app’s identifier, such as com.company.product:
```sh
log show --predicate '(messageType == error) and (subsystem == "com.company.product")' --style syslog --info | cut -c 1-22,43-999
```
