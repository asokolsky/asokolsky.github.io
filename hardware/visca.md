# Connecting VISCA Camera

Monoprice [camera 39512](https://www.monoprice.com/product?p_id=39512) with

* [VISCA](https://en.wikipedia.org/wiki/VISCA_Protocol)-controlled
Pan/Tilt/Zoom
* 1080p
* USB connection to computer
* VISCA serial socket present

Pleasant surprise: the USB3 interface includes a built-in USB->UART chip,
so a single USB3 cable can be used for both VISCA control and video streaming.

## Installation on Linux

No to braille display:
```sh
sudo apt remove brltty
```

Connect your USB camera - this may result in /dev/ttyUSB* being created!
Mine did just that!

Connect USB->serial converter, then check kernel messages for possible errors:

```sh
journalctl -b | tail -40
```

A device should have been created:
```sh
ls -la /dev/ttyUSB*
```

Expose it to all:
```sh
sudo chmod a+rw /dev/ttyUSB0
```
