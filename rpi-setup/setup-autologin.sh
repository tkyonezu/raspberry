#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# setup-autologin.sh - Setup Auto-Login
#
# usage: setup-autologin.sh <user>
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

error() {
  echo "ERROR: $1"
  exit 1
}

if [ $# -lt 1 ]; then
  error "Usage: $0 user"
fi

NEW_USER=$1

#
# Autologin
#
logmsg "Autologin user(${NEW_USER})"

sed -i "s/^autologin-user=.*/autologin-user=${NEW_USER}/" \
  /etc/lightdm/lightdm.conf

sed -i "s|^ExecStart=.*|ExecStart=^/sbin/agetty --autologin ${NEW_USER} --noclear %I \$TERM|" \
  /etc/systemd/system/autologin@.service

exit 0
