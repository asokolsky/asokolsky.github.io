# Configuring NUT with ProxMox

## Sources

## Configure UPS

[howto-configure-ups-on-proxmox](https://diyblindguy.com/howto-configure-ups-on-proxmox/)
https://networkupstools.org/
https://wiki.archlinux.org/index.php/Network_UPS_Tools
https://zackreed.me/installing-nut-on-ubuntu/

## Install

```
root@fuji:~# apt install nut
```

## Configuration

Configure the UPS:

```
root@fuji:~# cat /etc/nut/ups.conf
maxretry = 3
[theUPS]
driver = usbhid-ups
port = auto
desc = "the server UPS"
```

Find the UPS device ID:

```
root@fuji:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

Now ensure the UPS device ID is used for a "udev rule to allow nut user access to the driver":

```
root@fuji:/etc/nut# cat /etc/udev/rules.d/90-nut-ups.rules
# Rule for the UPS - use lsusb for idVendor and idProduct
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="051d", ATTR{idProduct}=="0002", MODE="0660", GROUP="nut"
```

Restart the udev service:
```
service udev restart
```

Set NUT into a stand-alone mode:

```
root@fuji:/etc/nut# cat /etc/nut/nut.conf
# IMPORTANT NOTE:
#  This file is intended to be sourced by shell scripts.
#  You MUST NOT use spaces around the equal sign!
MODE=standalone
```

Configure UPSD:

```
root@fuji:/etc/nut# cat /etc/nut/upsd.conf
LISTEN 127.0.0.1 3493
LISTEN ::1 3493

```

Continue as described in the above links.

## Testing

Use upsc to display the UPS information:

```
root@fuji:/etc/nut# upsc theUPS
Init SSL without certificate database
battery.charge: 100
battery.charge.low: 10
battery.charge.warning: 50
battery.date: 2001/09/25
battery.mfr.date: 2017/05/31
battery.runtime: 3036
battery.runtime.low: 120
battery.type: PbAc
battery.voltage: 27.3
battery.voltage.nominal: 24.0
device.mfr: American Power Conversion
device.model: Back-UPS RS1000G
device.serial: 3B1722X05468
device.type: ups
driver.name: usbhid-ups
driver.parameter.pollfreq: 30
driver.parameter.pollinterval: 2
driver.parameter.port: auto
driver.parameter.synchronous: no
driver.version: 2.7.4
driver.version.data: APC HID 0.96
driver.version.internal: 0.41
input.sensitivity: medium
input.transfer.high: 147
input.transfer.low: 88
input.transfer.reason: input voltage out of range
input.voltage: 117.0
input.voltage.nominal: 120
ups.beeper.status: disabled
ups.delay.shutdown: 20
ups.firmware: 868.L4 -P.D
ups.firmware.aux: L4 -P
ups.load: 9
ups.mfr: American Power Conversion
ups.mfr.date: 2017/05/31
ups.model: Back-UPS RS1000G
ups.productid: 0002
ups.realpower.nominal: 600
ups.serial: 3B1722X05468
ups.status: OL
ups.test.result: No test initiated
ups.timer.reboot: 0
ups.timer.shutdown: -1
ups.vendorid: 051d
```

Use upscmd to issue commands to UPS:

```
root@fuji:/etc/nut# upscmd -l theUPS
Instant commands supported on UPS [theUPS]:

beeper.disable - Disable the UPS beeper
beeper.enable - Enable the UPS beeper
beeper.mute - Temporarily mute the UPS beeper
beeper.off - Obsolete (use beeper.disable or beeper.mute)
beeper.on - Obsolete (use beeper.enable)
load.off - Turn off the load immediately
load.off.delay - Turn off the load with a delay (seconds)
shutdown.reboot - Shut down the load briefly while rebooting the UPS
shutdown.stop - Stop a shutdown in progress
test.battery.start.deep - Start a deep battery test
test.battery.start.quick - Start a quick battery test
test.battery.stop - Stop the battery test
test.panel.start - Start testing the UPS panel
test.panel.stop - Stop a UPS panel test
```

Check out status of nut-server, nut-client, ups-monitor:

```
root@fuji:/etc/nut# service ups-monitor status -l
● ups-monitor.service - LSB: Network UPS Tools monitor initscript
   Loaded: loaded (/etc/init.d/ups-monitor; generated)
   Active: active (exited) since Sat 2021-04-03 12:37:37 PDT; 40s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 7225 ExecStart=/etc/init.d/ups-monitor start (code=exited, status=0/SUCCESS)

Apr 03 12:37:37 fuji systemd[1]: Starting LSB: Network UPS Tools monitor initscript...
Apr 03 12:37:37 fuji ups-monitor[7225]: Starting NUT - power device monitor and shutdown controller: nut-client failed!
Apr 03 12:37:37 fuji systemd[1]: Started LSB: Network UPS Tools monitor initscript.
root@fuji:/etc/nut# service --status-all
 [ + ]  apparmor
 [ - ]  console-setup.sh
 [ + ]  cpufrequtils
 [ + ]  cron
 [ + ]  dbus
 [ - ]  hwclock.sh
 [ - ]  ipmievd
 [ + ]  iscsid
 [ - ]  keyboard-setup.sh
 [ + ]  kmod
 [ + ]  lm-sensors
 [ + ]  loadcpufreq
 [ - ]  lvm2
 [ + ]  networking
 [ - ]  nfs-common
 [ + ]  nut-client
 [ + ]  nut-server
 [ + ]  open-iscsi
 [ + ]  openipmi
 [ + ]  postfix
 [ + ]  procps
 [ + ]  rbdmap
 [ + ]  rpcbind
 [ + ]  rrdcached
 [ - ]  rsync
 [ + ]  rsyslog
 [ + ]  smartmontools
 [ + ]  ssh
 [ + ]  udev
 [ + ]  ups-monitor
 [ - ]  x11-common
```
