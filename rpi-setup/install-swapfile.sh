#!/bin/bash

BS=1M

if [ $# -eq 0 ]; then
  echo "Usage: $(basename $0): swapsize (GB)"
  exit 1
else
  NEW_SWAPSIZE=$1
  COUNT=$((${NEW_SWAPSIZE} * 1024))

  echo ">>> Make swapfile $${NEW_SWAPSIZE} GB"

  echo "$ sudo dd if=/dev/zero of=/var/swap/swapfile bs=1M count=${COUNT}"
  sudo dd if=/dev/zero of=/var/swap/swapfile bs=1M count=${COUNT}

  echo "$ sudo chmod 600 /var/swap/swapfile"
  sudo chmod 600 /var/swap/swapfile

  echo "$ sudo mkswap /var/swap/swapfile"
  sudo mkswap /var/swap/swapfile

  sudo echo "/var/swap/swapfile  none  swap  defaults  0  0" >>/etc/fstab

  echo ">>> Reboot system now!!!"
fi

exit 0
