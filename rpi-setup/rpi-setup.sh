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

if [ $# -lt 2 ]; then
  error "Usage: $0 hostname user"
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

sed -i -e 's/^XKBMODEL=.*/XKBMODEL="pc105"' \
  -e 's/^XKBLAYOUT=.*/XKBLAYOUT="jp"' \
  -e 's/^XKBOPTIONS=.*/XKBOPTIONS="terminate:ctrl_alt_bksp"' \
  /etc/default/keyboard

#
# Change Locale
#
logmsg "Change Locale (Japanese)"

DEBLANGUAGE="ja_JP.UTF-8"

rm /etc/locale.gen

dpkg-reconfigure -f noninteractive locales
update-locale LANG="$DEBLANGUAGE"

cat << EOF | debconf-set-selections
locales   locales/default_environment_locale select       $DEBLANGUAGE
EOF

## sed -i -e 's/^LANG=.*/LANG=ja_JP.UTF-8/' /etc/default/locale

# Change Timezone
logmsg "Change Timezone (Asia/Tokyo)"

echo "Asia/Tokyo" > /etc/timezone

dpkg-reconfigure --frontend noninteractive tzdata

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
logmsg "Install xrdp"

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

#
# Setup User
#
logmsg "Setup User (${NEW_USER})"

mv /home/pi /home/${NEW_USER}

sed -i "s/^pi/${NEW_USER}/" /etc/passwd
sed -i "s/^pi/${NEW_USER}/" /etc/shadow
sed -i "s/:pi/:${NEW_USER}/" /etc/group

cd /home/${NEW_USER}
mkdir .ssh
chown 1000:1000 .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chown 1000:1000 .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

#
# Autologin
#
logmsg "Autologin user(${NEW_USER})"

sed -i "s/^autologin-user=.*/autologin-user=${NEW_USER}/" \
  /etc/lightdm/lightdm.conf

sed -i "s|^ExecStart=.*|ExecStart=^/sbin/agetty --autologin ${NEW_USER} --noclear %I \$TERM|" \
  /etc/systemd/system/autologin@.service

#
# Chenage NTP server
#
logmsg "Change NTP server"

sed -i -e '/^server 3/apool ntp.nict.jp iburst' \
  -e 's/^server [0-9]/## &/' /etc/ntp.conf

#
# Install Docker
#
logmsg "Install Docker"

apt install -y apt-transport-https ca-certificates curl \
  software-properties-common

cat <<EOF >/etc/apt/sources.list.d/docker.list
deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main
#deb [arch=armhf] https://apt.dockerproject.org/repo debian-stretch main
EOF

curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

apt update

apt install -y docker-engine

#
# Upgrade Packages
#
apt update
apt upgrade -y

exit 0