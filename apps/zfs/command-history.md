# ZFS Command History on my (old) nass:

Create zpool:
```sh
zpool create -f tank raidz2 /dev/ada0 /dev/ada1 /dev/ada2 /dev/ada3 /dev/ada4
```
Create datasets:
```sh
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/home
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/downloads
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=off -o dedup=off -o sync=standard tank/moviesMore
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=off -o dedup=off -o sync=standard tank/movies
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/music
```

Replace damaged HD:
```sh
zpool offline tank 10462354999995531015
zpool import -d /dev -f -a
zpool replace tank 10462354999995531015 ada1
zpool import -d /dev -f -a
zpool import -d /dev -f -a
```

And:

```console
$ zdb -C | grep ashift
            ashift: 12
```
