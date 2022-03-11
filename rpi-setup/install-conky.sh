#!/bin/sh

#-----------------------------------------------------------------------
# Raspberry Pi 4B
#
# install-conky.sh - Install and Setup conky on Raspberry Pi
#
# usage: install-conky.sh
#
# Copyright (c) 2022 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

logmsg "Install conky"
sudo apt update
sudo apt install -y conky

cp conkyrc-1024x600 conkyrc-1920x1080 /var/tmp

cd $HOME/.config

if [ ! -f .conkyrc-1024x600 ]; then
  logmsg "Create .conkyrc-1024x600 file"
  cp /var/tmp/conkyrc-1024x600 .conkyrc-1024x600
fi

if [ ! -f .conkyrc-1920x1080 ]; then
  logmsg "Create .conkyrc-1920x1080 file"
  cp /var/tmp/conkyrc-1920x1080 .conkyrc-1920x1080
fi

if [ ! -h .conkyrc ]; then
  logmsg "Create symbolic link .conkyrc-1920x1080"
  ln -s .conkyrc-1024x600 .conkyrc
fi

rm -f /var/tmp/conkyrc-1024x600 /var/tmp/conkyrc-1920x1080

if [ ! -d lxsession ]; then
  mkdir lxsession
fi

cd lxsession
if [ ! -d LXDE-pi ]; then
  mkdir LXDE-pi
fi

cd LXDE-pi
if [ ! -f autostart ]; then
  logmsg "Create autostart file"
  cat <<EOF >autostart
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@conky -c /home/pi/.config/.conkyrc -p 5
EOF
else
  if ! grep -q conky autostart 2>/dev/null; then
    sed -i '$a@conky -c /home/pi/.config/.conkyrc -p 5' autostart
  fi
fi

logmsg "Please log in again to start conky."

exit 0
