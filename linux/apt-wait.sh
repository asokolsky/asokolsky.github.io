#!/usr/bin/env bash
#
# Wait for all known dpkg locks
#
function apt_wait () {
  while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    echo "Waiting on /var/lib/dpkg/lock..."
    sleep 1
  done
  while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do
    echo "Waiting on /var/lib/dpkg/lock-frontend..."
    sleep 1
  done
  while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    echo "Waiting on /var/lib/apt/lists/lock..."
    sleep 1
  done
  if [ -f /var/log/unattended-upgrades/unattended-upgrades.log ]; then
    while sudo fuser /var/log/unattended-upgrades/unattended-upgrades.log >/dev/null 2>&1 ; do
      echo "Waiting on /var/log/unattended-upgrades/unattended-upgrades.log..."
      sleep 1
    done
  fi
  # FIXME: wait for /var/cache/apt/archives/lock
  # /var/cache/apt/archives/lock
}
#
# to avoid "Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 5475 (unattended-upgr)"
#
apt_wait
