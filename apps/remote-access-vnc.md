# Remote Access to Linux Mint using VNC

## Server - tigerVNC

### Installation

```sh
sudo apt install tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer
```

Setup a password for vnc login:

```sh
vncpasswd
```
This creates `~/.vnc/passwd`.

To start TigerVNC server:
```sh
vncserver -depth {8|16|24|32} -geometry {width}x{height} -localhost no
```

e.g.
```sh
vncserver -depth 16 -geometry 1920x1080 -localhost no
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

Convenience script `~/.vnc.sh`:

```sh
#!/usr/bin/env bash
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
#set -o xtrace


case "${1:-unspecified}" in
    "start"|"Start"|"START" )
        vncserver -depth 16 -geometry 1920x1080 -localhost no ;;
    "stop" )
        vncserver -kill :1 ;;
    "list"|"ls" )
        vncserver -list ;;
    *)
        echo "vnc start|stop|list"
	exit 1
esac
```

### Configuration

The above only resulted in server failure. Followed
[steps](https://stackoverflow.com/questions/59709214/tigervncserver-crashes-unless-started-with-sudo):

```
✘ alex@exi > ~/.vnc > ls -la  /usr/share/xsessions/
total 24
drwxr-xr-x   2 root root  4096 Jan 17 14:26 .
drwxr-xr-x 339 root root 12288 Jan 19 18:27 ..
-rw-r--r--   1 root root   268 Jan 10 08:06 cinnamon2d.desktop
-rw-r--r--   1 root root   155 Jan 10 08:06 cinnamon.desktop
alex@exi > ~/.vnc > cat /usr/share/xsessions/cinnamon2d.desktop
[Desktop Entry]
Name=Cinnamon (Software Rendering)
Comment=This session logs you into Cinnamon (using software rendering)
Exec=cinnamon-session-cinnamon2d
TryExec=/usr/bin/cinnamon2d
Icon=
Type=Application
X-Ubuntu-Gettext-Domain=cinnamon
X-GNOME-Provides=cinnamon2d

alex@exi > ~/.vnc > cat /usr/share/xsessions/cinnamon.desktop
cat /usr/share/xsessions/cinnamon.desktop
[Desktop Entry]
Name=Cinnamon
Comment=This session logs you into Cinnamon
Exec=cinnamon-session-cinnamon
TryExec=/usr/bin/cinnamon
Icon=
Type=Application
```

Based on the above created  `~/.vnc/xstartup`:
```sh
#!/bin/bash

#PATH=/usr/bin:/usr/sbin
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec cinnamon-session-cinnamon
```


## Client - remmina - never worked

Use [remmina](https://remmina.org/how-to-install-remmina/).

```sh
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-vnc remmina-plugin-secret
```

In GUI when configuring for the server use: `<host-or-ip>:1`.  Remember to
enter the display number.

## Client - tigervnc-viewer

Install:
```sh
sudo apt install tigervnc-viewer
```

Connect:
```sh
xtigervncviewer exi:1
```
