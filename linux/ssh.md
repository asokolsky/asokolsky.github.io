# Configure SSH for Key-based Authentication

See also [Configure SSHD](sshd.html).

## Sources

* [SSH Key Tutorial](https://austinsnerdythings.com/2021/04/02/ssh-key-tutorial/)
* [ssh man page](https://man7.org/linux/man-pages/man1/ssh.1.html)
* [ssh-keygen man page](https://man7.org/linux/man-pages/man1/ssh-keygen.1.html)
* [ssh-add man page](https://man7.org/linux/man-pages/man1/ssh-add.1.html0)
* [Configuring Authorized Keys for OpenSSH](https://www.ssh.com/academy/ssh/authorized-keys-openssh)
* [The Ultimate SSH Guide](https://grimoire.carcano.ch/blog/openssh-tutorial-the-ultimate-ssh-guide-to-understand-it/)

## Generate SSH Key Pair

Generate the
[ED25519](https://linux-audit.com/using-ed25519-openssh-keys-instead-of-dsa-rsa-ecdsa/)
key using
[ssh-keygen](https://man7.org/linux/man-pages/man1/ssh-keygen.1.html):

```console
alex@latitude7490:~$ ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/alex/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/alex/.ssh/id_ed25519
Your public key has been saved in /home/alex/.ssh/id_ed25519.pub
```

Verify the generated files:

```console
$ ls -la ~/.ssh
total 48
drwx------  2 alex alex  4096 Dec 16 14:17 .
drwxr-xr-x 31 alex alex  4096 Mar 31 12:00 ..
-rw-------  1 alex alex   411 Sep 28  2021 id_ed25519
-rw-r--r--  1 alex alex    99 Sep 28  2021 id_ed25519.pub
-rw-------  1 alex alex  3381 Dec 28  2019 id_rsa
-rw-r--r--  1 alex alex   739 Dec 28  2019 id_rsa.pub
-rw-------  1 alex alex 11042 Jan 28 12:15 known_hosts
-rw-------  1 alex alex  9930 Dec 16 14:16 known_hosts.old
```
List the fingerprints currently used by ssh using
[ssh-add](https://www.man7.org/linux/man-pages/man1/ssh-add.1.html):
```
$ ssh-add -l
4096 SHA256:4sGkGvw2itx0TNFu8V+Bqk2lSdB8ZEHczXIGfmfWiZc alex@latitude (RSA)
```

Add the private key identities to the authentication agent,
[ssh-agent].
When run without arguments, it adds the files `~/.ssh/id_rsa`, `~/.ssh/id_dsa`,
`~/.ssh/id_ecdsa`, `~/.ssh/id_ecdsa_sk`, `~/.ssh/id_ed25519`, and
`~/.ssh/id_ed25519_sk`.

```
$ ssh-add
Identity added: /home/alex/.ssh/id_rsa (alex@latitude)
Identity added: /home/alex/.ssh/id_ed25519 (alex@latitude7490)
```

Confirm the key addition:
```
$ ssh-add -l
4096 SHA256:4sGkGvw2itx0TNFu8V+Bqk2lSdB8ZEHczXIGfmfWiZc alex@latitude (RSA)
256 SHA256:pD1ar4RV2Xuqup3/27JnAibnmHeQMJ4O4h05GI/e3R0 alex@latitude7490 (ED25519)
```

## Create Account on a Remote Computer

```sh
uname=alex
useradd -m $uname
passwd $uname
adduser $uname sudo
usermod -aG sudo $uname
usermod -aG adm $uname
usermod -s /bin/bash $uname
```

## Copy ID to a Remote Computer

Copy a default ID:
```console
alex@latitude7490:~$ ssh-copy-id alex@fuji
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
alex@fuji's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'alex@fuji'"
and check to make sure that only the key(s) you wanted were added.
```

Alternatively, copy the specific ID:
```sh
ssh-copy-id -i ~/.ssh/id_rsa.pub alex@192.168.100.177
```

## Enjoy it

```console
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
