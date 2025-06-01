# nut on TrueNas

## Configuration

Configured via GUI.  Whish results in....

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
