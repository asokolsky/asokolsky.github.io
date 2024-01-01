# Upgrading OS in LXC Container

Backup the container

## Debian 11 (bullseye) -> 12 (bookworm)

Follow [these steps](https://wiki.debian.org/DebianUpgrade):

Start with:
```sh
apt-get update
apt-get upgrade
apt-get full-upgrade
```

Then replace references to bullseye with bookworm:
* edit `/etc/apt/sources.list`.
[bookworm sources.list](https://gist.github.com/hakerdefo/5e1f51fa93ff37871b9ff738b05ba30f).
* edit files in `/etc/apt/sources.list`

Then:
```sh
apt-get clean
apt-get update
apt-get upgrade
apt-get full-upgrade
apt-get autoremove
```

If `apt update` results in
```
W: https://foo/bar: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
```

Try:
```sh
mv /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/
```