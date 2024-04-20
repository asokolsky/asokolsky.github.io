---
title: Sanity Checks
tags: software
---

Nas4free seems to be most suited to my requirements, but samba there just
crashes on me.
In the meantime I am collecting network and hard drives throughput data on
Windows.

HTPC runs Windows 7, NAS in this test runs Windows Vista.
Both use Intel 82540EM PRO/1000 MT PCI NICs.
Rate of data copying between two internal SATA2 drives on HTPC: windows copy
dialog shows 120MB/sec in the beginning of the copy process.
By the end it falls down to 87MB/sec.
Writing to NAS (to 300MB Seagate HD) is done at a rate of 43MB/sec.
Reading from NAS is done at a rate of 40MB/sec.

iperf bandwidth measurement between HTPC and another Windows PC is about 38MB/sec.
Enabling jumbo frames (or changing their size from 4k to 9k) has no effect at all.
I have no idea why the bandwidth is so low.
I ordered a CAT6 cable and will try one more time bandwidth tests with two
Windows PCs connected directly with no switch in between.

EDIT: later I
[determined](http://nasfuss.blogspot.com/2012/04/open-indiana-take2.html)
that PCI NICs are the bottleneck!

Todo:

* install syslog on the LAN to collect debugging info, e.g.  syslog-win32
* Experiment with Wake-on-LAN - here is client which would wake NAS up.


While waiting for the production version of firmware to materialize and
production HBA to show up on my door step I was pondering over the hard drive
use strategy.  Should I go with RAIDZ?  Given that the NAS cage can hold up to
4 drivers, and I do not plan to expand, my options are limited to RAIDZ and
MIRROR.  Here are two good articles on the subject.  Decided!  I will go with a
mirror of two Barracuda Green 2TB drives.

[Original post](https://nasfuss.blogspot.com/2012/04/sanity-check.html)

2012-04-11-hardware.md
