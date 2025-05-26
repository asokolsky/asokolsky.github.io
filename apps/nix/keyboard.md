# Keyboard Customization in NixOS

in `configuration.nix`:

```
  services.xserver = {
    # https://nixos.org/manual/nixos/stable/options#opt-services.xserver.enable
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:swapcaps";
  };

```

Build it normally with `sudo nixos-rebuild switch`.

```
sudo nixos-rebuild boot
sudo reboot
```

Then run these:

```sh
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```
Then reboot.
