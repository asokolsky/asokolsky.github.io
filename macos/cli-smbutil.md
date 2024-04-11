# smbutil

[smbutil](https://www.unix.com/man-page/osx/1/smbutil/) is a MacOS CLI to samba,
similar to [smbclient](/linux/cli-smbclient.html).
[smbutil freebsd](https://man.freebsd.org/cgi/man.cgi?query=smbutil&format=html).

```
> smbutil status 192.168.10.30
Using IP address of 192.168.10.30: 192.168.10.30
Workgroup: WORKGROUP
Server: NASS.LAN

> smbutil identity //alex@192.168.10.30
Password for 192.168.10.30:

Network User:   alex
Network Domain: NASS.LAN
Network SID:    S-1-5-21-1097164062-3553569808-191310426-20035
Local User:     asokolsky
Local SID:      S-1-5-21-1946377265-2225559908-2256467161-2006

> smbutil view //alex@192.168.10.30
Password for 192.168.10.30:
Share                                           Type    Comments
-------------------------------
alex                                            Disk    Home directory of alex
downloads                                       Disk
IPC$                                            Pipe    IPC Service (TrueNAS Server)
movies                                          Disk
music                                           Disk
homes                                           Disk
```
