# MKVToolNix on Linux Mint

[mkvtoolnix](https://mkvtoolnix.download/).  See also [mkvtool](mkvtool.html).

## Install

Identify the code-name of Ubuntu I am running:

```
> cat /etc/os-release|grep -i ubuntu
ID_LIKE="ubuntu debian"
UBUNTU_CODENAME=noble
```

The follow the [recommendations for ubuntu](https://mkvtoolnix.download/downloads.html#ubuntu):

```sh
sudo wget -O /etc/apt/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
```
Edit the file:
```
sudo emacs /etc/apt/sources.list.d/mkvtoolnix.download.list
```

```
deb [arch=amd64 signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ noble main
deb-src [arch=amd64 signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ noble main
```

Finally:
```sh
sudo apt install mkvtoolnix mkvtoolnix-gui
```
