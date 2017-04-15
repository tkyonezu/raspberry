#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# rpi-setup.sh - Raspbian first setup script
#
# usage: rpi-setup.sh <hostname>
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
  error "Usage: $0 hostname"
fi

#
# Change Hostname
#
logmsg "Change Hostname"

NEW_HOSTNAME=$1
CURRENT_HOSTNAME=$(cat /etc/hostname | tr -d " \t\n\r")

sed -i "s/127.0.1.1.*${CURRENT_HOSTNAME}/127.0.1.1\t${NEW_HOSTNAME}/g" /etc/hosts
cat ${NEW_HOSTNAME} >/etc/hostname

# Change Keyboard
logmsg "Change Keyboard (Japanese)"

sed -i -e 's/^XKBMODEL=.*/XKBMODEL="pc105"' \
  -e 's/^XKBLAYOUT=.*/XKBLAYOUT="jp"' \
  -e 's/^XKBOPTIONS=.*/XKBOPTIONS="terminate:ctrl_alt_bksp" \
  /etc/default/keyboard

#
# Change Locale
#
logmsg "Change Locale (Japanese)"

sed -i -e 's/^LANG=.*/LANG=ja_JP.UTF-8/' \
  /etc/default/locale

# Change Timezone
logmsg "Change Timezone (Asia/Tokyo)"

echo "Asia/Tokyo" > /etc/timezone

# ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

#
# Japanese InputMethod
#
logmsg "Setup Japanese InputMethod"

apt install ttf-kochi-gothic ttf-kochi-mincho \
  xfonts-intl-japanese xfonts-intl-japanese-big \
  xfonts-kaname

apt install -y uim uim-anthy

#
# Change WiFi Country
#
logmsg "Change WiFi Country (Japan)"

sed -i 's/^country=.*/country=JP/'
  /etc/wpa_supplicant/wpa_supplicant.conf

#
# Disable Swap
#
logmsg "Disable Swap"

swap=$(swapon -s | sed 1d | awk '{ print $1 }')

if [[ "$swap" == "/var/swap" ]]; then
  dphys-swapfile swapoff
  insserv -r dphys-swapfile
fi

#
# Enable ssh
#
logmsg "Enable ssh daemon"

systemctl enable ssh.service
systemctl start ssh.service

#
# Install xrdp
#
apt -y install xrdp

# If you have some trouble to connect with RDP, re-install xrdp.
#
# apt remove -y xrdp
#
# apt update
# apt install -y tightvncserver
# apt install -y xrdp

#
# Install Software Keyboard
#

exit 0
