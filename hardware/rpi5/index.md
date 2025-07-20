# rpi5

Customizations:

* enabled sshd
* disabled [rpi-connect](https://www.raspberrypi.com/documentation/services/connect.html):
```sh
sudo apt remove --purge rpi-connect
```
* use [vcgencmd](cli-vcgencmd.html)
