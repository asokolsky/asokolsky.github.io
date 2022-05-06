# ProxMox CLI

## VM Manipulation

Show VMs:

```console
cat /etc/pve/.vmlist
```

Delete VM by id:

```console
qm destroy <vmid>
```

If the above fails because the machine is locked:

```console
qm unlock <VMID>
```

## Container Manipulation

List containers:
```console
pct list
```
Start and enter into a container (without password):

```console
pct start VMID
pct enter VMID
```

## Container Templates

```console
pveam update
pveam available
pveam download local ubuntu-18.10-standard_18.10-2_amd64.tar.gz
```
