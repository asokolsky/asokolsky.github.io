# iperf3

Start server, e.g. on pfSense.

Then:

```console
alex@latitude7490:~$ iperf3 -v
iperf 3.7 (cJSON 1.5.2)
Linux latitude7490 5.4.0-88-generic #99-Ubuntu SMP Thu Sep 23 17:29:00 UTC 2021 x86_64
Optional features available: CPU affinity setting, IPv6 flow label, SCTP, TCP congestion algorithm setting, sendfile / zerocopy, socket pacing, authentication

lex@latitude7490:~$ iperf3 -c 192.168.11.1
Connecting to host 192.168.11.1, port 5201
[  5] local 192.168.11.100 port 46926 connected to 192.168.11.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   952 Mbits/sec    0   1.11 MBytes
[  5]   1.00-2.00   sec   111 MBytes   933 Mbits/sec    0   1.11 MBytes
[  5]   2.00-3.00   sec   111 MBytes   933 Mbits/sec    0   1.11 MBytes
[  5]   3.00-4.00   sec   111 MBytes   933 Mbits/sec    0   1.11 MBytes
[  5]   4.00-5.00   sec   112 MBytes   944 Mbits/sec    0   1.11 MBytes
[  5]   5.00-6.00   sec   111 MBytes   933 Mbits/sec    0   1.11 MBytes
[  5]   6.00-7.00   sec   111 MBytes   933 Mbits/sec    0   1.17 MBytes
[  5]   7.00-8.00   sec   111 MBytes   933 Mbits/sec    0   1.17 MBytes
[  5]   8.00-9.00   sec   111 MBytes   933 Mbits/sec    0   1.17 MBytes
[  5]   9.00-10.00  sec   111 MBytes   933 Mbits/sec    0   1.17 MBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.09 GBytes   936 Mbits/sec    0             sender
[  5]   0.00-10.00  sec  1.09 GBytes   933 Mbits/sec                  receiver

iperf Done.
```
