# Configuring Hosts for SSH Key Authentication

## Sources

e.g. https://austinsnerdythings.com/2021/04/02/ssh-key-tutorial/

## Generate SSH Key Pair

```
alex@latitude7490:~$ ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/alex/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/alex/.ssh/id_ed25519
Your public key has been saved in /home/alex/.ssh/id_ed25519.pub
```

## Create Account on a Remote Computer

```
uname=alex
useradd -m $uname
passwd $uname
adduser $uname sudo
usermod -aG sudo $uname
usermod -aG adm $uname
usermod -s /bin/bash $uname
```


## Copy ID to a Remote Computer

```
alex@latitude7490:~$ ssh-copy-id alex@fuji
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
alex@fuji's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'alex@fuji'"
and check to make sure that only the key(s) you wanted were added.

alex@latitude7490:~$ ssh alex@fuji
Linux fuji 5.4.114-1-pve #1 SMP PVE 5.4.114-1 (Sun, 09 May 2021 17:13:05 +0200) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Sep 28 11:24:18 2021 from 192.168.10.141
alex@fuji:~$ ls -ls ~/.ssh
total 4
4 -rw------- 1 alex alex 99 Sep 28 11:17 authorized_keys
```
