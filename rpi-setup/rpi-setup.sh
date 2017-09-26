#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# rpi-setup.sh - Raspbian first setup script
#
# usage: rpi-setup.sh <hostname> <user>
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

if [ $# -lt 2 ]; then
  error "Usage: $0 <hostname> <user>"
fi

NEW_HOSTNAME=$1
NEW_USER=$2

#
# Change Hostname
#
logmsg "Change Hostname"

CURRENT_HOSTNAME=$(cat /etc/hostname | tr -d " \t\n\r")

sed -i "s/127.0.1.1.*${CURRENT_HOSTNAME}/127.0.1.1\t${NEW_HOSTNAME}/g" /etc/hosts
echo ${NEW_HOSTNAME} >/etc/hostname

# Change Keyboard
logmsg "Change Keyboard (Japanese)"

sed -i -e 's/^XKBMODEL=.*/XKBMODEL="pc105"/' \
  -e 's/^XKBLAYOUT=.*/XKBLAYOUT="jp"/' \
  -e 's/^XKBOPTIONS=.*/XKBOPTIONS="terminate:ctrl_alt_bksp"/' \
  /etc/default/keyboard

#
# Change Locale
#
logmsg "Change Locale (Japanese)"

DEBLANGUAGE="ja_JP.UTF-8"

cat << EOF | debconf-set-selections
locales   locales/locales_to_be_generated multiselect     $DEBLANGUAGE UTF-8
EOF

rm /etc/locale.gen

dpkg-reconfigure -f noninteractive locales
update-locale LANG="$DEBLANGUAGE"

## sed -i -e 's/^LANG=.*/LANG=ja_JP.UTF-8/' /etc/default/locale

# Change Timezone
logmsg "Change Timezone (Asia/Tokyo)"

timedatectl set-timezone Asia/Tokyo

## ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

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

sed -i 's/^country=.*/country=JP/' \
  /etc/wpa_supplicant/wpa_supplicant.conf

#
# Disable Swap
#
logmsg "Disable Swap"

swap=$(swapon -s | sed 1d | awk '{ print $1 }')

if [[ "$swap" == "/var/swap" ]]; then
  ## # For Debian jessie
  ## dphys-swapfile swapoff
  ## insserv -r dphys-swapfile
  # For Debian stretch
  systemctl stop dphys-swapfile.service
  systemctl disable dphys-swapfile.service
fi

#
# Chenage NTP server
#
logmsg "Change NTP server"

sed -i -e '/^server 3/apool ntp.nict.jp iburst' \
  -e 's/^server [0-9]/## &/' /etc/ntp.conf

#
# Enable ssh
#
logmsg "Enable ssh daemon"

systemctl enable ssh.service
systemctl start ssh.service
#
# Setup User
#
logmsg "Setup User (${NEW_USER})"

mv /home/pi /home/${NEW_USER}

sed -i "s/^pi/${NEW_USER}/g" /etc/passwd
sed -i "s/^pi/${NEW_USER}/" /etc/shadow
sed -i -e "s/^pi:/${NEW_USER}:/" -e "s/:pi/:${NEW_USER}/" /etc/group

cd /home/${NEW_USER}
mkdir .ssh
chown 1000:1000 .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chown 1000:1000 .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

cd /etc/sudoers.d
mv 010_pi-nopasswd 010_${NEW_USER}-nopasswd
sed -i "s/^pi /${NEW_USER} /" 010_${NEW_USER}-nopasswd

#
# Update Firmware
#
rpi-update

#
# Upgrade Packages
#
logmsg "Update Packages"

apt update
apt upgrade -y

exit 0
