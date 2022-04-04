## Benchmarking Linux Performance

### Disk Performance

This [speed-test.sh](speed-test.sh) is based on `dd`:

```sh
> ./speed-test.sh
Writing to /tmp...
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.06011 s, 1.0 GB/s
Reading from /tmp...
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.436509 s, 2.5 GB/s
Benchmarking CPU...
1+0 records in
1+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 1.90138 s, 565 MB/s
cd573cfaace07e7949bc0c46028904ff  -
```
Apparently using `dd` is a [bad
idea](https://www.unixmen.com/how-to-measure-disk-performance-with-fio-and-ioping/).

fio: [man page](https://linux.die.net/man/1/fio),
[docs](https://fio.readthedocs.io/en/latest/fio_doc.html),
[examples from repo](https://github.com/axboe/fio/tree/master/examples),
[example use](https://docs.oracle.com/en-us/iaas/Content/Block/References/samplefiocommandslinux.htm)

```sh
> ./fio-test.sh
Random Read/Write Test
[sudo] password for alex:
test: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.16
Starting 1 process
test: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1)
test: (groupid=0, jobs=1): err= 0: pid=324881: Mon Apr  4 06:29:14 2022
  read: IOPS=69.5k, BW=272MiB/s (285MB/s)(768MiB/2826msec)
   bw (  KiB/s): min=262520, max=317936, per=100.00%, avg=279023.20, stdev=22286.14, samples=5
   iops        : min=65630, max=79484, avg=69755.80, stdev=5571.54, samples=5
  write: IOPS=23.2k, BW=90.7MiB/s (95.1MB/s)(256MiB/2826msec); 0 zone resets
   bw (  KiB/s): min=86272, max=106216, per=100.00%, avg=93109.40, stdev=7634.07, samples=5
   iops        : min=21568, max=26554, avg=23277.20, stdev=1908.59, samples=5
  cpu          : usr=17.45%, sys=31.08%, ctx=128123, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=196498,65646,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s), io=768MiB (805MB), run=2826-2826msec
  WRITE: bw=90.7MiB/s (95.1MB/s), 90.7MiB/s-90.7MiB/s (95.1MB/s-95.1MB/s), io=256MiB (269MB), run=2826-2826msec

Disk stats (read/write):
  nvme0n1: ios=183808/61434, merge=31/9, ticks=157613/607, in_queue=158222, util=96.50%
```
