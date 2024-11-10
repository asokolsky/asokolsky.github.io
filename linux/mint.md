# Linux Mint Customization

Customizing Linux Mint desktop.

## Applets

Setting / Applets

defaults +:

* Multi-Core System Monitor

## Applications

* [CoreCtrl](https://gitlab.com/corectrl/corectrl)
* [GreenWithEnvy](https://gitlab.com/leinardi/gwe)

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
