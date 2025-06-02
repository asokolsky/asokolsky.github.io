# Kernel Modules

https://www.tecmint.com/load-and-unload-kernel-modules-in-linux/

## List

Read the contents of `/proc/modules`:

```sh
cat /proc/modules
```
better yet:
```sh
lsmod
```

## Low Level Module Load/UnLoad

Load the `speedstep-lib.ko` module:

```sh
insmod /lib/modules/4.4.0-21-generic/kernel/drivers/cpufreq/speedstep-lib.ko
```

Unload (remove) the `speedstep-lib.ko` module:

```sh
rmmod /lib/modules/4.4.0-21-generic/kernel/drivers/cpufreq/speedstep-lib.ko
```

## Manage Kernel Modules Using `modprobe`

[modprobe man page](https://www.man7.org/linux/man-pages/man8/modprobe.8.html)

`modprobe` searches the module directory `/lib/modules/$(uname -r)` for the
modules and related files, but excludes alternative configuration files in
`/etc/modprobe.d` directory.

To insert a module:
```sh
modprobe speedstep-lib
```

To remove the module:
```sh
modprobe -r speedstep-lib
```

Note: Under modprobe, automatic underscore conversion is performed, so there is
no difference between _ and – while entering module names.

## Blacklisting modules

Locations to check:

* `/etc/modprobe.d/*`
* `/lib/modprobe.d/*`

e.g.
```sh
grep nvidia /etc/modprobe.d/* /lib/modprobe.d/*
```
