# Intel Quick Assist

## Hardware

Sources:

* https://github.com/openzfs/zfs/discussions/12723

Identify hardware:
```
> lspci -v
87:00.0 Co-processor: Intel Corporation C62x Chipset QuickAssist Technology (rev 04)
```

List relevant modules:
```sh
lsmod | grep -E 'zfs|qat'
```

Module details:
```sh
modinfo qat_c3xxx
```
or
```sh
modinfo qat_c62x
```

Looking into proc filesystem:

```sh
grep qat /proc/crypto
```

Then
```sh
cat /proc/spl/kstat/zfs/qat
```
