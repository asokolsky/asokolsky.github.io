# ZFS Snapshots


To list the snapshots:
```sh
zfs list -t snapshot -o name,used,referenced,creation
```

To list the snapshots of in a specific pool:
```sh
zfs list -t snapshot -r boot-pool -o name,used,referenced,creation
```

Dry-run the snapshot destruction:
```sh
zfs destroy -n -v tank/home@aapltm-1659945511
```

See also [zfs-prune-snapshots](https://github.com/bahamas10/zfs-prune-snapshots).
