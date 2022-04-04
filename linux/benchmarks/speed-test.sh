#!/bin/bash
#
#  Benchmarking Disk & CPU
#
TEST_DIR=/tmp
BS=1G
COUNT=1

echo Writing to $TEST_DIR...
dd if=/dev/zero of=$TEST_DIR/junk bs=$BS count=$COUNT oflag=dsync

echo Reading from $TEST_DIR...
dd if=$TEST_DIR/junk of=/dev/null bs=$BS count=$COUNT oflag=dsync
rm $TEST_DIR/junk

echo Benchmarking CPU...
dd if=/dev/zero bs=$BS count=$COUNT | md5sum
