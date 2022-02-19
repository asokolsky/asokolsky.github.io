# Linux Remote Key Mapping

I want to customize keys of the
[Logitech Presenter R800](https://www.logitech.com/en-us/products/presenters/r800-professional-presenter.910-001350.html)
remote.  But the technique should be applicable to any keyboard.

Information sources:

* [source1](https://derickrethans.nl/logitech-r400-take2.html);
* [source2](https://github.com/Shuunen/snippets/blob/master/manuals/logitech-r400-remap.md);
* [Finding USB devices with lsusb & idVendor –
idProduct](https://www.derekdemuro.com/2020/06/06/finding-usb-devices-with-lsusb-idvendor-idproduct/);
* comments in `/lib/udev/hwdb.d/60-keyboard.hwdb`.

## Steps

* connect your peripheral;
* run `sudo evtest` to examine events generated when you press the keys;
* add to `/lib/udev/hwdb.d/60-keyboard.hwdb`:

```
# Logitech Presenter R800
evdev:input:b0003v046DpC538*
 KEYBOARD_KEY_07004b=left
 KEYBOARD_KEY_07004e=right
 KEYBOARD_KEY_070029=playpause
 KEYBOARD_KEY_07003e=playpause
 KEYBOARD_KEY_070037=displaytoggle
```

* update hardware db by running:
```console
$ sudo systemd-hwdb update
$ sudo udevadm trigger --verbose --sysname-match="event*"
```
