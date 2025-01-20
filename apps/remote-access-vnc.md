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


## Client - remmina


Use [remmina](https://remmina.org/how-to-install-remmina/).

```sh
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
```

Worked as expected.

Tips:

* in the client preferences set resolution to dynamic.

Problems:

* PolicyKit1 KDE agent dialog:
`Authentication is required to create a color managed device`.
