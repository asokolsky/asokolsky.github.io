# Tuning Linux Kernel

Edit `/etc/sysctl.conf` to make changes persistent.

## Less Swapping

To set it:

```
sudo sysctl vm.swappiness=10

```
Check it
```
cat /proc/sys/vm/swappiness
```

Set in `/etc/sysctl.conf`:

```
vm.swappiness = 0
```

## Adjust Cache

For IO server allow more dirty pages, less dirty cache:

* [Kernel Tuning for Kafka](https://youtu.be/7dkSze52i-o?t=1607)
* [Better linux disk caching
performance](https://lonesysadmin.net/2013/12/22/better-linux-disk-caching-performance-vm-dirty_ratio/)

In `/etc/sysctl.conf` set:
```
vm.dirty_background_ratio = 5
vm.dirty_ratio = 80
```

## IPv6

I see no reason not to set in `/etc/sysctl.conf`:
```
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
```
