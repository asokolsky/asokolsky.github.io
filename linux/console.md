# Linux Console

## Grub Menu

Menu will appear if:

* if you boot using BIOS, you press and hold `Shift` during loading Grub;
* if you boot using UEFI, press Esc.

For permanent change you'll need to edit your `/etc/default/grub` file:

Comment out (using # symbol at the start of line)  `GRUB_HIDDEN_TIMEOUT=0`

If that line doesn't exist, then you can comment out this line instead:
`# GRUB_TIMEOUT_STYLE=hidden`, and then change `GRUB_TIMEOUT=0` to
`GRUB_TIMEOUT=5`.

Save changes and run sudo update-grub to apply changes.

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

To switch to a console: `Ctrl`+`Alt`+`F1`...`F6`.  To switch back:
`Ctrl`+`Alt`+`F7`.
