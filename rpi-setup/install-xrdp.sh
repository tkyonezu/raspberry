#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# install-xrdp.sh - Instll XRDP
#
# usage: install-xrdp.sh
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

#
# Install xrdp
#
logmsg "Install xrdp"

## apt -y install xrdp

# If you have some trouble to connect with RDP, re-install xrdp.
apt remove -y xrdp

apt update
apt install -y tightvncserver
apt install -y xrdp

exit 0
