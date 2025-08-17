# Customize Wayland

## Keyboard

Need to swap CapsLock and Ctrl.

### Use dconf

https://opensource.com/article/21/5/remap-caps-lock-key-linux

```sh
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"
```

Alternatively install `dconf-editor` and make this change interactively.

Tried.  Did not work.

### Use keyd

[keyd](keyd.html) worked.
