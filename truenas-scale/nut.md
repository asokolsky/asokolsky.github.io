# nut on TrueNas

## Status

```
root@nass:~# systemctl status nut-monitor
● nut-monitor.service - Network UPS Tools - power device monitor and shutdown controller
     Loaded: loaded (/lib/systemd/system/nut-monitor.service; enabled; preset: disabled)
     Active: active (running) since Thu 2026-03-26 17:51:50 PDT; 5min ago
   Main PID: 748885 (upsmon)
      Tasks: 2 (limit: 38017)
     Memory: 812.0K
        CPU: 23ms
     CGroup: /system.slice/nut-monitor.service
             ├─748885 /lib/nut/upsmon -F
             └─748887 /lib/nut/upsmon -F

Mar 26 17:51:50 nass systemd[1]: Started nut-monitor.service - Network UPS Tools - power device monitor and shutdown controller.
Mar 26 17:51:50 nass nut-monitor[748885]: fopen /run/nut/upsmon.pid: No such file or directory
Mar 26 17:51:50 nass nut-monitor[748885]: Could not find PID file to see if previous upsmon instance is already running!
Mar 26 17:51:50 nass nut-monitor[748885]: UPS: ups@localhost:3493 (primary) (power value 1)
Mar 26 17:51:50 nass nut-monitor[748887]: Init SSL without certificate database


root@nass:~# systemctl status nut-server
● nut-server.service - Network UPS Tools - power devices information server
     Loaded: loaded (/lib/systemd/system/nut-server.service; enabled; preset: disabled)
     Active: active (running) since Thu 2026-03-26 17:51:50 PDT; 3min 44s ago
   Main PID: 748828 (upsd)
      Tasks: 1 (limit: 38017)
     Memory: 572.0K
        CPU: 317ms
     CGroup: /system.slice/nut-server.service
             └─748828 /lib/nut/upsd -F

Mar 26 17:51:50 nass upsd[748828]: not listening on 0.0.0.0 port 3493
Mar 26 17:51:50 nass nut-server[748828]: not listening on 0.0.0.0 port 3493
Mar 26 17:51:50 nass nut-server[748828]: /run/nut is world readable
Mar 26 17:51:50 nass upsd[748828]: /run/nut is world readable
Mar 26 17:51:50 nass upsd[748828]: Connected to UPS [ups]: usbhid-ups-ups
Mar 26 17:51:50 nass nut-server[748828]: Connected to UPS [ups]: usbhid-ups-ups
Mar 26 17:51:50 nass nut-server[748828]: Running as foreground process, not saving a PID file
Mar 26 17:51:50 nass upsd[748828]: Running as foreground process, not saving a PID file
Mar 26 17:51:50 nass nut-server[748828]: User upsmon@::ffff:127.0.0.1 logged into UPS [ups]
Mar 26 17:51:50 nass upsd[748828]: User upsmon@::ffff:127.0.0.1 logged into UPS [ups]
```

## Configuration

Configured via GUI.  Which results in....

`/etc/nut/ups.conf`:
```
[ups]
        driver = usbhid-ups
        port = auto
        desc = ""
```

`/etc/nut/nut.conf`:
```
MODE=netserver
```

`/etc/nut/upsd.conf`:
```
LISTEN 0.0.0.0 3493
LISTEN ::0 3493
```

`/etc/nut/upsd.users`:
```
[upsmon]
        password = UpsMon
        upsmon master
```

`/etc/nut/upsmon.conf`:
```
MONITOR ups@localhost:3493 1 upsmon UpsMon MASTER
NOTIFYCMD /usr/sbin/upssched
NOTIFYFLAG ONBATT SYSLOG+EXEC
NOTIFYFLAG LOWBATT SYSLOG+EXEC
NOTIFYFLAG ONLINE SYSLOG+EXEC
NOTIFYFLAG COMMBAD SYSLOG+EXEC
NOTIFYFLAG COMMOK SYSLOG+EXEC
NOTIFYFLAG REPLBATT SYSLOG+EXEC
NOTIFYFLAG NOCOMM SYSLOG+EXEC
NOTIFYFLAG FSD SYSLOG+EXEC
NOTIFYFLAG SHUTDOWN SYSLOG+EXEC
SHUTDOWNCMD "/sbin/shutdown -P now"
HOSTSYNC 15
```

## Use

```
root@nass[~]# upsc ups
Init SSL without certificate database
battery.charge: 100
battery.charge.low: 10
battery.charge.warning: 50
battery.date: not set
battery.mfr.date: 2011/07/24
battery.runtime: 150
battery.runtime.low: 120
battery.type: PbAc
battery.voltage: 13.5
battery.voltage.nominal: 12.0
device.mfr: APC
device.model: Back-UPS ES 550
device.serial: 4B1130P52215
device.type: ups
driver.name: usbhid-ups
driver.parameter.pollfreq: 30
driver.parameter.pollinterval: 2
driver.parameter.port: auto
driver.parameter.synchronous: auto
driver.version: 2.8.0
driver.version.data: APC HID 0.98
driver.version.internal: 0.47
driver.version.usb: libusb-1.0.26 (API: 0x1000109)
input.sensitivity: medium
input.transfer.high: 139
input.transfer.low: 92
input.voltage: 121.0
input.voltage.nominal: 120
ups.beeper.status: enabled
ups.delay.shutdown: 20
ups.firmware: 843.K2 .D
ups.firmware.aux: K2
ups.load: 23
ups.mfr: APC
ups.mfr.date: 2011/07/24
ups.model: Back-UPS ES 550
ups.productid: 0002
ups.serial: 4B1130P52215
ups.status: OL
ups.timer.reboot: 0
ups.timer.shutdown: -1
ups.vendorid: 051d
```

List supported commands:
```
> upscmd -l ups
Instant commands supported on UPS [ups]:

beeper.disable - Disable the UPS beeper
beeper.enable - Enable the UPS beeper
beeper.mute - Temporarily mute the UPS beeper
beeper.off - Obsolete (use beeper.disable or beeper.mute)
beeper.on - Obsolete (use beeper.enable)
load.off - Turn off the load immediately
load.off.delay - Turn off the load with a delay (seconds)
shutdown.reboot - Shut down the load briefly while rebooting the UPS
shutdown.stop - Stop a shutdown in progress
test.panel.start - Start testing the UPS panel
test.panel.stop - Stop a UPS panel test
```

Unfortunately:

```
root@nass:~# upscmd -u upsmon -p UpsMon ups beeper.disable
Unexpected response from upsd: ERR ACCESS-DENIED
```

## Battery Maintenance

Read values:
```
# upsrw -u upsmon -p UpsMon ups
[battery.charge.low]
Remaining battery level when UPS switches to LB (percent)
Type: STRING
Maximum length: 10
Value: 10

[battery.mfr.date]
Battery manufacturing date
Type: STRING
Maximum length: 10
Value: 2011/07/24

[battery.runtime.low]
Remaining battery runtime when UPS switches to LB (seconds)
Type: STRING
Maximum length: 10
Value: 120

[input.sensitivity]
Input power sensitivity
Type: STRING
Maximum length: 10
Value: medium

[input.transfer.high]
High voltage transfer point (V)
Type: STRING
Maximum length: 10
Value: 139

[input.transfer.low]
Low voltage transfer point (V)
Type: STRING
Maximum length: 10
Value: 92

[ups.delay.shutdown]
Interval to wait after shutdown with delay command (seconds)
Type: STRING
Maximum length: 10
Value: 20
```

After the battery is updated, update the `battery.mfr.date` setting:
```sh
upsrw -s battery.mfr.date=2026/03/01 -u upsmon -p UpsMon ups
```

got:
```
Unexpected response from upsd: ERR ACCESS-DENIED
```