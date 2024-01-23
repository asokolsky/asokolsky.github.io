# Using Deluge on a headless server

Sources:

* https://www.rapidseedbox.com/kb/ultimate-deluge-guide
* [User Guide](https://dev.deluge-torrent.org/wiki/UserGuide)


## Create user account

```sh
sudo groupadd deluge
sudo useradd -r -m -d /var/lib/deluge -s /usr/sbin/nologin -g deluge deluge
```

## Install Components

```sh
sudo apt install deluged deluge-console deluge-web
```

Verify:
```
> deluged --version
deluged 2.1.2.dev0
libtorrent: 2.0.9.0
Python: 3.11.6
OS: Linux Ubuntu 23.10 mantic
```

```sh
sudo systemctl enable deluged
sudo systemctl start deluged
```

## Configuration

https://dev.deluge-torrent.org/wiki/UserGuide/Authentication

```sh
echo "alex:password:10" >> ~/.config/deluge/auth
```
