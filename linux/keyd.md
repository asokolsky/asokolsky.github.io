# keyd

[keyd](https://github.com/rvaiya/keyd)

## Install

Build and install:
```sh
git clone https://github.com/rvaiya/keyd
cd keyd
make
sudo make install
```

## Configuration

```sh
sudo mkdir /etc/keyd
sudo emacs /etc/keyd/default.conf
```

`/etc/keyd/default.conf`:
```
[ids]
*

[main]
capslock = layer(control)
#leftalt = esc
#esc = capslock
```

## Use

Run it:
```sh
sudo make install
sudo systemctl enable keyd --now
```
