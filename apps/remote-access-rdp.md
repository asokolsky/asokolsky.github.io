# Remote Access to Ubuntu Studio 23.xx using RDP

## Server

Use [this script](https://c-nergy.be/blog/?p=19228).

In the context of the ssh session.

```sh
wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.4.8.zip
unzip xrdp-installer-1.4.8.zip
chmod +x xrdp-installer-1.4.8.sh
```

Then just launch the script with no options.


## Client


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
