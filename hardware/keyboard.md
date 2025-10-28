# Keyboard

## Keychron Keyboards

* [K1 Low Profile Bluetooth Mechanical](keychron/k1.html)
* [C3 Pro QMK/VIA Programmable 87 Keys](./keychron/c3pro.html)

## Logi Keyboards

* [MS Mechanical Mini](logi/mx-mechanical-mini.html)
* [Wave Keys](logi/wave-keys.html)
* [Presenter R800](logi/remote.md) Remote

## Troubleshooting

Also see [linux keyboard](../linux/keyboard.html)

[lsusb](https://linux.die.net/man/8/lsusb)

```
> lsusb
Bus 001 Device 012: ID c0f4:08f5 Usb KeyBoard Usb KeyBoard

> lsusb -v -s 001:012
Bus 001 Device 012: ID c0f4:08f5 Usb KeyBoard Usb KeyBoard
...
  idVendor           0xc0f4 Usb KeyBoard
  idProduct          0x08f5 Usb KeyBoard
  bcdDevice            1.00
  iManufacturer           1 Usb KeyBoard
  iProduct                2 Usb KeyBoard
  iSerial                 0
  bNumConfigurations      1
```

[evtest](https://manpages.ubuntu.com/manpages/trusty/man1/evtest.1.html)

```
> sudo evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      Sleep Button
/dev/input/event1:      Power Button
...
/dev/input/event17:     Usb KeyBoard Usb KeyBoard
/dev/input/event18:     Usb KeyBoard Usb KeyBoard Consumer Control
/dev/input/event19:     Usb KeyBoard Usb KeyBoard System Control
/dev/input/event2:      Power Button
/dev/input/event20:     Usb KeyBoard Usb KeyBoard Keyboard
...
```

[udevadm](https://www.freedesktop.org/software/systemd/man/latest/udevadm.html)

```sh
udevadm info --no-pager /dev/input/event20
```

## Generic USB Numeric Keypad

I want to remap the numeric keypd keys to something unique to be able to make
global shortcuts for OBS scene switching.
