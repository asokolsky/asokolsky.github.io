# pdsh

Parallel ssh.
[Man page](https://linux.die.net/man/1/pdsh).

## Install

Add to you `.bashrc` or `.zshrc` (or better yet to `.zshenv`):

```
export PDSH_RCMD_TYPE=ssh
```

## Examples

```sh
$ pdsh -w fuji,duo uname -a
duo: Linux duo 5.13.19-3-pve #1 SMP PVE 5.13.19-7 (Thu, 20 Jan 2022 16:37:56 +0100) x86_64 GNU/Linux
fuji: Linux fuji 5.13.19-4-pve #1 SMP PVE 5.13.19-9 (Mon, 07 Feb 2022 11:01:14 +0100) x86_64 GNU/Linux

$ pdsh -w fuji,duo uptime
duo:  12:12:16 up 30 days, 14:48,  0 users,  load average: 0.15, 0.15, 0.10
fuji:  12:12:16 up 39 days, 23:03,  0 users,  load average: 0.01, 0.07, 0.08
```

Show top 3 CPU consumers:

```sh
pdsh -w fuji,duo 'ps -eo pcpu,pid,user,args|sort -k 1 -nr|head -3'
```

## Example of passing a sudo password

```sh
$ pdsh -w fuji,duo echo 'password'|sudo -S apt-get update
```
