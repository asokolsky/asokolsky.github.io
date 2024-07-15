# Linux Console

## Grub Menu

Menu will appear if, during loading Grub:

* if you boot using BIOS, press and hold `Shift`;
* if you boot using UEFI, press Esc.

For permanent change you'll need to edit your `/etc/default/grub` file:

Comment out: `# GRUB_HIDDEN_TIMEOUT=0`

If that line doesn't exist, then:

* comment out: `# GRUB_TIMEOUT_STYLE=hidden`;
* set `GRUB_TIMEOUT=2`.

To apply the changes: `sudo update-grub`.

## Boot into Console

1. Edit in `/etc/default/grub`:

```
# Uncomment to disable graphical terminal (grub-pc only)
GRUB_TERMINAL=console
```

2. Run a `sudo update-grub`.

3. Switch `systemd` [target](cli-systemctl-targets.html):
```sh
sudo systemctl enable multi-user.target --force
sudo systemctl set-default multi-user.target
```

4. Reboot your computer: `sudo reboot`.

## Switch Consoles

To switch to a console: `Ctrl`+`Alt`+`F1`...`F6`.

To switch back: `Ctrl`+`Alt`+`F7`.
