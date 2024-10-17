# Linux Keyboard Input

## Architecture and Abstraction Layers

Abstraction layers,
[from low to high ](https://wiki.archlinux.org/title/Keyboard_input):

* [scancode](https://en.wikipedia.org/wiki/Scancode)
* [keycode](https://wiki.archlinux.org/title/Map_scancodes_to_keycodes)
* [keyboard layout](https://en.wikipedia.org/wiki/Keyboard_layout)

Relevant apps:

* [keyd](https://github.com/rvaiya/keyd/) - seems like a MUST-HAVE!

## Swap Ctrl and CapsLock by manipulating the keyboard layout

This:

* should be sufficient for all good X11/Wayland citizens, including terminal
apps AND
* can be done in the GUI.

Therefore this is the easiest way to set things up!

Install the tweak-tool:

```sh
sudo apt-get install gnome-tweak-tool
```

Then: `Keyboard & Mouse` / `Additional Layout Options` / `Caps Lock behavior`,
select, e.g., `Caps Lock is also a Ctrl`.

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

### Alternative #2, use udev

This sequence of steps worked for me.  If you are not using `systemd` - you are
on your own.

#### Step 1. Boot into text console

Get the current [systemctl target](cli-systemctl-targets.html):
```sh
systemctl get-default
```

I've got `graphical.target`.  Remember this.  We will restore it in step 3.

Now set the default target to `multi-user.target`:
```sh
sudo systemctl set-default multi-user.target
```

and reboot, e.g. with `sudo reboot`.

#### Step 2.  Use udev to remap scancode to keycode

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

Manually update the `/etc/udev/hwdb.bin` to include newly created
`/etc/udev/hwdb.d/90-custom-keyboard.hwdb`:

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
#sudo udevadm info
```

By now your CapsLock and Ctrl should be swapped.  This worked on my new laptop
but not on an old one. Go figure `;-(`.

#### Step 3. Boot back into GUI

```sh
sudo systemctl set-default graphical.target
sudo reboot
```

Verify the GUI retained the remapped keys.
