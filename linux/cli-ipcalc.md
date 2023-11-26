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

## IPv4 Address Ranges

From [RFC 5735](https://www.rfc-editor.org/rfc/rfc5735):

Address Block|Present Use|Reference
-------------|-----------|---------
0.0.0.0/8|"This" Network|[RFC 1122, Section 3.2.1.3](https://www.rfc-editor.org/rfc/rfc1122#section-3.2.1.3)
10.0.0.0/8|Private-Use Networks|[RFC 1918](https://www.rfc-editor.org/rfc/rfc1918)
100.64.0.0/10|Shared address space|[RFC 6598](https://www.rfc-editor.org/rfc/rfc6598)
127.0.0.0/8|Loopback|[RFC 1122, Section 3.2.1.3](https://www.rfc-editor.org/rfc/rfc1122#section-3.2.1.3)
169.254.0.0/16|Link Local|[RFC 3927](https://www.rfc-editor.org/rfc/rfc3927)
172.16.0.0/12|Private-Use Networks|[RFC 1918](https://www.rfc-editor.org/rfc/rfc1918)
192.0.0.0/24|IETF Protocol Assignments|[RFC 5736](https://www.rfc-editor.org/rfc/rfc5736)
192.0.2.0/24|TEST-NET-1|[RFC 5737](https://www.rfc-editor.org/rfc/rfc5737)
192.88.99.0/24|6to4 Relay Anycast|[RFC 3068](https://www.rfc-editor.org/rfc/rfc3068)
192.168.0.0/16|Private-Use Networks|[RFC 1918](https://www.rfc-editor.org/rfc/rfc1918)
198.18.0.0/15|Network Interconnect, Device Benchmark Testing|[RFC 2544](https://www.rfc-editor.org/rfc/rfc2544)
198.51.100.0/24|TEST-NET-2|[RFC 5737](https://www.rfc-editor.org/rfc/rfc5737)
203.0.113.0/24|TEST-NET-3|[RFC 5737](https://www.rfc-editor.org/rfc/rfc5737)
224.0.0.0/4|Multicast|[RFC 3171](https://www.rfc-editor.org/rfc/rfc3171)
240.0.0.0/4|Reserved for Future Use|[RFC 1112, Section 4](https://www.rfc-editor.org/rfc/rfc1112#section-4)
255.255.255.255/32|Limited Broadcast|[RFC 919, Section 7](https://www.rfc-editor.org/rfc/rfc919#section-7), [RFC 922, Section 7](https://www.rfc-editor.org/rfc/rfc922#section-7)
