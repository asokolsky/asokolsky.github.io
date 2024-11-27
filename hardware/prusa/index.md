# Prusa 3D Printers

## MK3s+

* local [octoprint](http://octo:5000/),
[how to set it up](/proxmox/lxc-octoprint.html).
* local [prusalink](http://192.168.11.78:8080/),
[how to set it up](/proxmox/lxc-prusalink.html).
* [dead-end-project](mk3s-rpi0w.html)

### Firmware Upgrade

* Download and install the latest PrusaSlicer, now 2.8.1.
* Download [firmware](https://help.prusa3d.com/downloads/mk3s-2/firmware) now
in 3.14.0.
* Launch PrusaSlicer.
* From the menu select Configuration / Flash Printer Firmware.
* Connect the printer to your computer using the USB A to USB2 B cable.
* Choose the printer from the list. Hit Rescan if the printer is not on the
list.
* Select the downloaded firmware file on your hard drive (.hex).
Do not place the firmware on a network share.
* Hit the Flash button.

To fix the permission error:
```sh
sudo adduser alex dialout
```

## MK4

* [Prusa Link](http://PrusaMK4)
* [firmware](https://help.prusa3d.com/downloads/mk4/firmware) now in 6.1.3.
* [Prusa Connect](https://connect.prusa3d.com/)
* [hardware details](mk4.html)

## Useful g-code

[M115](https://reprap.org/wiki/G-code#M115:_Get_Firmware_Version_and_Capabilities) -
report firmware version
