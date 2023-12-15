# Certbot

[About certbot](https://certbot.eff.org/pages/about)

## Installation

### MacOS

```sh
brew install certbot
```

### Linux

From https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal

Presuming
[snapd is already installed](https://snapcraft.io/docs/installing-snapd):

```sh
sudo snap install --classic certbot
```

You may need:
```sh
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

Get the cert:
```sh
sudo certbot certonly --nginx
```
