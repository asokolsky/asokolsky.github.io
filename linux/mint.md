# Linux Mint Customization

Customizing Linux Mint desktop.

## Applets

Setting / Applets

defaults +:

* Multi-Core System Monitor

## Applications

* [CoreCtrl](https://gitlab.com/corectrl/corectrl)
* [GreenWithEnvy](https://gitlab.com/leinardi/gwe)
* [Mission Center](https://gitlab.com/mission-center-devs/mission-center)

## Rotate Login Screen

Pick the monitor where login is displayed:
Setting / Login Window / Settings / Monitor

Did not work:
```sh
cd /var/lib/lightdm
cp /home/alex/.config/cinnamon-monitors.xml monitors.xml
```

## Volume Control CLI

From [WirePlumber](https://wiki.archlinux.org/title/WirePlumber#Keyboard_volume_control):

To raise the volume, with a limit of 150%:
```sh
wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
```
To lower the volume:
```sh
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
```
To mute/unmute the volume:
```sh
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```
To mute/unmute the microphone:
```sh
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
```

## Fingerprint Reader

On my t14g3 `lsusb` gives `06cb:00f9 Synaptics, Inc.`

[Instructions](https://forums.linuxmint.com/viewtopic.php?t=408129) worked.

In the end I was disappointed.  It insisted on using the fingerprint reader even when the lid is closed.

To disable: `sudo pam-auth-update`
