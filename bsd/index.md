# FreeBSD Stuff

## More Files

* driveid.sh
* systemps.sh

## Display Partition Table in FreeBSD

```
# geom disk list
# geom disk list ada5
```

More: https://www.cyberciti.biz/faq/freebsd-hard-disk-information/

## gpart

Show all the partitions:

```
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
