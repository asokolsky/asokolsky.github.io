# ipcalc

## Installation

On ubuntu derivatives, as expected, `sudo apt install ipcalc` does the job.

Also available on macos via usual `brew`.

## Use Examples

Display info on
[cidr](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
10.8.0.0/20:

```sh
$ ipcalc 10.8.0.0/20
Address:   10.8.0.0             00001010.00001000.0000 0000.00000000
Netmask:   255.255.240.0 = 20   11111111.11111111.1111 0000.00000000
Wildcard:  0.0.15.255           00000000.00000000.0000 1111.11111111
=>
Network:   10.8.0.0/20          00001010.00001000.0000 0000.00000000
HostMin:   10.8.0.1             00001010.00001000.0000 0000.00000001
HostMax:   10.8.15.254          00001010.00001000.0000 1111.11111110
Broadcast: 10.8.15.255          00001010.00001000.0000 1111.11111111
Hosts/Net: 4094                  Class A, Private Internet
```

Split the above cidr into three /24 subnets:

```sh
$ ipcalc 10.8.0.0/20 --s 128 128 128
Address:   10.8.0.0             00001010.00001000.0000 0000.00000000
Netmask:   255.255.240.0 = 20   11111111.11111111.1111 0000.00000000
Wildcard:  0.0.15.255           00000000.00000000.0000 1111.11111111
=>
Network:   10.8.0.0/20          00001010.00001000.0000 0000.00000000
HostMin:   10.8.0.1             00001010.00001000.0000 0000.00000001
HostMax:   10.8.15.254          00001010.00001000.0000 1111.11111110
Broadcast: 10.8.15.255          00001010.00001000.0000 1111.11111111
Hosts/Net: 4094                  Class A, Private Internet

1. Requested size: 128 hosts
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Network:   10.8.0.0/24          00001010.00001000.00000000. 00000000
HostMin:   10.8.0.1             00001010.00001000.00000000. 00000001
HostMax:   10.8.0.254           00001010.00001000.00000000. 11111110
Broadcast: 10.8.0.255           00001010.00001000.00000000. 11111111
Hosts/Net: 254                   Class A, Private Internet

2. Requested size: 128 hosts
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Network:   10.8.1.0/24          00001010.00001000.00000001. 00000000
HostMin:   10.8.1.1             00001010.00001000.00000001. 00000001
HostMax:   10.8.1.254           00001010.00001000.00000001. 11111110
Broadcast: 10.8.1.255           00001010.00001000.00000001. 11111111
Hosts/Net: 254                   Class A, Private Internet

3. Requested size: 128 hosts
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Network:   10.8.2.0/24          00001010.00001000.00000010. 00000000
HostMin:   10.8.2.1             00001010.00001000.00000010. 00000001
HostMax:   10.8.2.254           00001010.00001000.00000010. 11111110
Broadcast: 10.8.2.255           00001010.00001000.00000010. 11111111
Hosts/Net: 254                   Class A, Private Internet

Needed size:  768 addresses.
Used network: 10.8.0.0/22
Unused:
10.8.3.0/24
10.8.4.0/22
10.8.8.0/21
```
