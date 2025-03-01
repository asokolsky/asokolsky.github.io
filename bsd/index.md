# FreeBSD Stuff

Manuals:

* [FreeBSD Handbook](https://docs.freebsd.org/en/books/handbook/), [sysctl utility](https://docs.freebsd.org/en/books/handbook/config/#configtuning-sysctl)
* [FreeBSD Tuning and Optimization](https://calomel.org/freebsd_network_tuning.html)
* [KDE on FreeBSD](https://community.kde.org/FreeBSD/Setup)
* [FreeBSD Series](https://vermaden.wordpress.com/)
* [How to Check Hard Drive Health](https://www.osetc.com/en/how-to-check-hard-drive-health-on-freebsd.html)
* [Using FreeBSD with Ports](https://eerielinux.wordpress.com/2019/08/18/using-freebsd-with-ports-1-2-classic-way-with-tools/)
* [How To Install Nginx, MySQL and PHP on FreeBSD 12.0](https://docs.vultr.com/how-to-install-nginx-mysql-and-php-femp-stack-on-freebsd-12-0)

## Package Management

[man pkg](https://man.freebsd.org/cgi/man.cgi?pkg)

To list files installed by the package `rsyslog`:

```sh
pkg info -l rsyslog
```
## Checking up on sockets

Use [man netstat](https://man.freebsd.org/cgi/man.cgi?query=netstat), or,
better yet, [man sockstat](https://man.freebsd.org/cgi/man.cgi?query=sockstat).

To display listening sockets:
```sh
sockstat -l
```

## Display Partition Table in FreeBSD

```console
# geom disk list
# geom disk list ada5
```

More: https://www.cyberciti.biz/faq/freebsd-hard-disk-information/

## gpart

Show all the partitions:

```console
root@nass[~]# gpart show
=>      40  61865904  ada6  GPT  (30G)
        40    532480     1  efi  (260M)
    532520  61308928     2  freebsd-zfs  (29G)
  61841448     24496        - free -  (12M)

=>         40  11721045088  ada5  GPT  (5.5T)
           40           88        - free -  (44K)
          128      4194304     1  freebsd-swap  (2.0G)
      4194432  11716850696        - free -  (5.5T)

root@nass[~]# gpart show ada5
=>         40  11721045088  ada5  GPT  (5.5T)
           40           88        - free -  (44K)
          128      4194304     1  freebsd-swap  (2.0G)
      4194432  11716850696        - free -  (5.5T)

root@nass[~]# gpart delete -i 1 ada5
ada5p1 deleted
root@nass[~]# gpart show ada5
=>         40  11721045088  ada5  GPT  (5.5T)
           40  11721045088        - free -  (5.5T)

root@nass[~]# gpart destroy ada5
ada5 destroyed
root@nass[~]# gpart show ada5
gpart: No such geom: ada5.
```

## driveid

```sh
{% include_relative driveid.sh %}
```

## systemps

```sh
{% include_relative systemps.sh %}
```
