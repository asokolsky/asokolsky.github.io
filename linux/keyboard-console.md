# Linux Keyboard in a Console

[Overall context](keyboard.html).

To switch to a console: `Ctrl`+`Alt`+`F1`...`F6`.  To switch back:
`Ctrl`+`Alt`+`F7`.

The rest is about manipulating keymap, e.g. to swap `CapsLock` with `Ctrl`.

To manipulate the keyboard layout in a
[virtual console](http://en.wikipedia.org/wiki/Virtual_console) use
[dumpkeys](https://man7.org/linux/man-pages/man1/dumpkeys.1.html),
[showkey](https://man7.org/linux/man-pages/man1/showkey.1.html) and
[loadkeys](https://www.m,an7.org/linux/man-pages/man1/loadkeys.1.html).
Man for [keymap file](https://www.man7.org/linux/man-pages/man5/keymaps.5.html).

[More info](https://www.mail-archive.com/puredyne@goto10.org/msg01407.html)

## Save the Keymap

```sh
sudo dumpkeys > backup.kmap
```

## Check the keycodes

Use `sudo showkey` to learn the keycodes:


* Left Ctrl - 29, denoted `Control`
* CapsLock - 58, denoted `CtrlL_Lock`

## Create a new keymap

Create file `swap-capslock-ctrl.kmap`:
```
keymaps 0-127
keycode  29 = CtrlL_Lock
keycode  58 = Control
```

## Load the keymap

```sh
sudo loadkeys swap-capslock-ctrl.kmap
```
