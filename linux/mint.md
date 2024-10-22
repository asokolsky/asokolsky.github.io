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
