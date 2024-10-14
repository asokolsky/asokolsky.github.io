#!/bin/bash
#
#  Benchmarking Disk Using fio
#
TEST_DIR=/tmp
JOBS=4
FILENAME=$TEST_DIR/junk

echo Random Read/Write Test
sudo fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 \
    --name=test --filename=$FILENAME --bs=4k --iodepth=64 --size=1G \
    --readwrite=randrw --rwmixread=75

sudo rm -f $FILENAME
