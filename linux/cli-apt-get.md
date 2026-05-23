# apt-get / dpkg

- Advanced Package Tool -
  [apt-get man page](https://linux.die.net/man/8/apt-get)
- Debian Package -
  [dpkg man page](https://man7.org/linux/man-pages/man1/dpkg.1.html)
- [apt vs dpkg](https://www.geeksforgeeks.org/difference-between-apt-and-dpkg-in-ubuntu/):
  `dpkg` is .. the low-level package manager, it (deals with the) .deb files, BUT
  does not perform dependency resolution.
  On the other hand, `apt` is a high (abstraction level) package manager.
  `apt` deals with dependencies and can retrieve packages from the online
  repositories.

## List Packages Installed

```sh
apt list --installed
```

## Identify the Package That Owns the File

```sh
dpkg -S /bin/ls
```

## Waiting on the apt/dpkg locks

[apt-wait.sh](apt-wait.sh):

```sh
{% include_relative apt-wait.sh %}
```

## Specify lock timeout on the command line

```sh
APT_GET_OPTIONS="-o DPkg::Lock::Timeout=60"
sudo apt-get "${APT_GET_OPTIONS}" install -y _package_
```

## Clean-up

Free space in `/var/cache/apt/archives/` - from most to least conservative...

Remove Unused Dependencies - removes packages that were installed as dependencies but are no longer needed:

```sh
apt autoremove
```
Partial (Conservative) Clean - removes only outdated package files that can no longer be downloaded.
```sh
apt autoclean
```

Total Clean - recommended for space - removes all downloaded .deb package files from the cache.
```sh
apt clean
```
