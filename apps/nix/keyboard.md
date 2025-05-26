# Keyboard Customization in NixOS

in `configuration.nix`:

```
console = {
  font = "Lat2-Terminus16";  
  # use X keyboard bindings
  useXkbConfig = true;  
};

services.xserver = {
  enable = true;
  
  layout = "us";
  xkbVariant = "altgr-intl";
  xkbOptions = "ctrl:swapcaps";
  
  displayManager.gdm.enable = true;
  desktopManager.gnome3.enable = true;
  displayManager.gdm.wayland = true
  
  libinput.enable = true;
};
```

Build it normally with `sudo nixos-rebuild switch`.

Then run these:

```sh
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```
Then reboot.
