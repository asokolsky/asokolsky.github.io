# ProxMox CLI

## VM Manipulation

Show VMs:

```sh
cat /etc/pve/.vmlist
```

Delete VM by id:

```sh
qm destroy <vmid>
```

If the above fails because the machine is locked:

```sh
qm unlock <VMID>
```

## Container Manipulation

List containers:
```sh
pct list
```
Start and enter into a container (without password):

```sh
pct start VMID
pct enter VMID
```

## Container Templates

```sh
pveam update
pveam available
pveam download local ubuntu-18.10-standard_18.10-2_amd64.tar.gz
```
