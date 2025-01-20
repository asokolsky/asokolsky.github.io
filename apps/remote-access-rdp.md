# Remote Access to Mint/Ubuntu Studio 23.xx using RDP

[RDP](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) server on linux and client on ...whatever.

## Server using gnome-remote-desktop (Failed)

[gnome-remote-desktop](https://gitlab.gnome.org/GNOME/gnome-remote-desktop)

Install it:
```sh
sudo apt install gnome-remote-desktop
```

[Generate TLS key and certificate](https://gitlab.gnome.org/GNOME/gnome-remote-desktop#tls-key-and-certificate-generation):

```sh
mkdir -p ~/.local/share/gnome-remote-desktop/
openssl req -new -newkey rsa:4096 -days 720 -nodes -x509 \
    -subj /C=US/ST=NONE/L=NONE/O=GNOME/CN=gnome.org \
    -out ~/.local/share/gnome-remote-desktop/tls.crt \
    -keyout ~/.local/share/gnome-remote-desktop/tls.key
```

Steps for [Headless (single user) RDP](https://gitlab.gnome.org/GNOME/gnome-remote-desktop#headless-single-user) config of gnome remote desktop:

This:
```sh
grdctl --headless rdp set-tls-key ~/.local/share/gnome-remote-desktop/tls.key
```
failes with
```
Init TPM credentials failed because Failed to initialize transmission interface context: tcti:IO failure, using GKeyFile as fallback.
```

Workaround from [here](https://bugs.launchpad.net/ubuntu/+source/gnome-remote-desktop/+bug/2063333):
```sh
sudo systemd-sysusers
sudo systemd-tmpfiles --create /usr/lib/tmpfiles.d/gnome-remote-desktop-tmpfiles.conf
sudo systemd-sysusers /usr/lib/sysusers.d/gnome-remote-desktop-sysusers.conf
sudo systemd-tmpfiles --create /usr/lib/tmpfiles.d/gnome-remote-desktop-tmpfiles.conf
```
did NOT work.  Ignore it for now.

```sh
grdctl --headless rdp set-tls-cert ~/.local/share/gnome-remote-desktop/tls.crt
export PASSWORD=****
grdctl --headless rdp set-credentials $USER $PASSWORD
grdctl --headless rdp enable
```

Then:

```
alex@exi > grdctl status
RDP:
	Status: enabled
	Port: 3389
	TLS certificate: /home/alex/.local/share/gnome-remote-desktop/tls.crt
	TLS fingerprint: ******
	TLS key: /home/alex/.local/share/gnome-remote-desktop/tls.key
	View-only: yes
	Negotiate port: yes
	Username: (hidden)
	Password: (hidden)
```

Alternatively:
```
gsettings list-recursively org.gnome.desktop.remote-desktop.rdp
org.gnome.desktop.remote-desktop.rdp enable true
org.gnome.desktop.remote-desktop.rdp negotiate-port true
org.gnome.desktop.remote-desktop.rdp port uint16 3389
org.gnome.desktop.remote-desktop.rdp screen-share-mode 'mirror-primary'
org.gnome.desktop.remote-desktop.rdp tls-cert '/home/alex/.local/share/gnome-remote-desktop/tls.crt'
org.gnome.desktop.remote-desktop.rdp tls-key '/home/alex/.local/share/gnome-remote-desktop/tls.key'
org.gnome.desktop.remote-desktop.rdp view-only true

```

Finally:

```sh
systemctl --user enable gnome-remote-desktop.service
systemctl --user restart gnome-remote-desktop.service
```

Config stored in : `/usr/share/gnome-remote-desktop`.

### gnome-remote-desktop Configuration

Use `gnome-control-center`:

```sh
XDG_CURRENT_DESKTOP=GNOME gnome-control-center
```

Does not reflect what `grdctl status`.

## Server using xrdp

Install [xrdp](https://en.wikipedia.org/wiki/Xrdp) using [this script](https://c-nergy.be/blog/?p=20178).

Install:

```sh
wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.5.3.zip
unzip xrdp-installer-1.5.3.zip
chmod +x xrdp-installer-1.5.3.sh
```

Then just launch the script with no options.

To verify:L
```sh
systemctl status xrdp.service
systemctl status xrdp-sesman.service
```
To verify the socket:
```
ss -lnt|grep 3389
```

## Client - Linux


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

## Client - MacOS

[FreeRDP](https://github.com/FreeRDP/FreeRDP)
