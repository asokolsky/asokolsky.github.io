# ProxMox CLI

## VM Manipulation

Show VMs:

```
cat /etc/pve/.vmlist
```

Delete VM by id:

```
qm destroy <vmid>
```

If the above fails because the machine is locked:

```
qm unlock <VMID>
```

## Container Manipulation

List containers:
```
pct list
```
Start and enter into a container (without password):

```
pct start VMID
pct enter VMID
```

## Container Templates

```
pveam update
pveam available
pveam download local ubuntu-18.10-standard_18.10-2_amd64.tar.gz
```
