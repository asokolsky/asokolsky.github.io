# ZFS CLI

## Create a Dataset

Create a dataset for ISO storage:

```sh
zfs create POOL/ISO
```

# Manipulate Flags

To turn compression on for the pool:

```sh
zfs set compression=lz4 POOLNAME
```
