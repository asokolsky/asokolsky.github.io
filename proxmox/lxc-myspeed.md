# MySpeed in an LXC Container

## Prep

Create an LXC using debian template.  Use DHCP, configure the DHCP server to
have a static IP allocated to the MAC of this LXC.


Then:

```sh
apt update
apt upgrade
apt install nodejs npm
apt install node-express
```

## Installation

Follow the [docs](https://docs.myspeed.dev/setup/linux/):

```sh
mkdir /opt/myspeed && cd /opt/myspeed
wget $(curl -s https://api.github.com/repos/gnmyt/myspeed/releases/latest | grep browser_download_url | cut -d '"' -f 4)
unzip MySpeed-*.zip && rm MySpeed-*.zip
npm install
```

Create service file as in [docs](https://docs.myspeed.dev/setup/linux/):

```sh
nano /etc/systemd/system/myspeed.service
```

```sh
systemctl enable myspeed
systemctl start myspeed
```

To check status:

```sh
systemctl status myspeed
```

Point your browser to `http://_lxc_ip_:5216/` to proceed.
