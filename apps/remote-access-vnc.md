# Remote Access to Linux Mint using VNC

## Server - tigerVMC

```sh
sudo apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer
```

setup a password for vnc login:

```sh
vncpasswd
```
This creates `~/.vnc/`.

To start TigerVNC server:
```sh
vncserver -depth {8|16|24|32} -geometry {width}x{height}
```

To verify server running:
```
pgrep Xtigervnc
ss -tulpn | grep -E -i 'vnc|590'
```

To list VNC server sessions:
```sh
vncserver -list
```

To stop TigetVNC server:

```sh
vncserver -kill :1
```


## Client - remmina - never worked


Use [remmina](https://remmina.org/how-to-install-remmina/).

```sh
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-vnc remmina-plugin-secret
```

In gui when convifguring the server: <host-or-ip>:1 - remember to enter the display number.

## Client - tigervnc-viewer

Install:
```sh
sudo apt install tigervnc-viewer
```

Connect:
```sh
xtigervncviewer exi:1
```
