# Linux Keyboard Input

## Architecture and Abstraction Layers

Abstraction layers,
[from low to high ](https://wiki.archlinux.org/title/Keyboard_input):

* [scancode](https://en.wikipedia.org/wiki/Scancode)
* [keycode](https://wiki.archlinux.org/title/Map_scancodes_to_keycodes)
* [keyboard layout](https://en.wikipedia.org/wiki/Keyboard_layout)

## Swap Ctrl and CapsLock by manipulating the keyboard layout

This:

* should be sufficient for all good X11/Wayland citizens, including terminal
apps AND
* can be done in the GUI.

Therefore this is an easiest way to set things up!

Install the tweak-tool:

```sh
sudo apt-get install gnome-tweak-tool
```

Then:

* `Keyboard & Mouse` /
* `Additional Layout Options` /
* `Caps Lock behavior`
* Select, e.g., `Caps Lock is also a Ctrl`.

This does NOT work in:

* console
* some remote desktop apps, e.g. for taking CKA exam.

## Swap Ctrl and CapsLock by manipulating the keymap

[Linux Keyboard in a Console](keyboard-console.html).

Not tested extensively. I thought I might as well do what is described in the
next section.

## Swap Ctrl and CapsLock by remapping scancode to keycode

[Map scancodes to keycodes](https://wiki.archlinux.org/title/Map_scancodes_to_keycodes),
man [udev](https://www.man7.org/linux/man-pages/man7/udev.7.html),
[setkeycodes](https://linux.die.net/man/8/setkeycodes),
[showkey](https://man7.org/linux/man-pages/man1/showkey.1.html).


To [identify the scancodes](https://wiki.archlinux.org/title/Keyboard_input#Identifying_scancodes),
run `sudo showkey -s` and press the keys of interest. I learned the following
scancodes:

* CapsLock - 0x3a
* Ctrl - 0x1d

To identify the keycodes, run `sudo showkey -k` and press the keys of
interest.  I learned the following keycodes:

* CapsLock - 58
* Ctrl - 29

From man page: "It is hardwired in the current kernel that in the range 1-88
(0x01-0x58) keycode equals scancode".

### Alternative #1, use setkeycodes, NOT for USB keyboards

NOTE: "USB keyboards have standardized keycodes and `setkeycodes` does NOT
affect them at all."  If still interested, to swap CapsLock with Control:

```sh
setkeycodes 3a 29 1d 58
```

### Aternative #2, use udev

Create `/etc/udev/hwdb.d/90-custom-keyboard.hwdb`:

```
evdev:atkbd:*
 KEYBOARD_KEY_3a=leftctrl
 KEYBOARD_KEY_1d=capslock
```

Each line is in the format: `KEYBOARD_KEY_<scancode>=<keycode>`, where

* the `<scancode>` is a hexadecimal without the leading `0x`;
* the `<keycode>` is the lower-case keycode name string as listed in
`/usr/include/linux/input-event-codes.h` - see the `KEY_<KEYCODE>` defines,
[sorted list](https://hal.freedesktop.org/quirk/quirk-keymap-list.txt).

Manually update the `/etc/udev/hwdb.bin`:

```sh
sudo systemd-hwdb update
```
Reload the Hardware Database Index using
[udevadm](https://www.man7.org/linux/man-pages/man8/udevadm.8.html):
```sh
sudo udevadm trigger
```

To verify:
```sh
sudo udevadm info
```
