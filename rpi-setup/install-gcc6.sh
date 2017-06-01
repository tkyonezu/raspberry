#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# install-gcc6.sh - Install Gcc-6
#
# usage: install-gcc6.sh
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

#
# Install gcc-6
#
logmsg "Install gcc-6"

sed -i '/^deb /s/jessie/stretch/' /etc/apt/sources.list
apt update

apt install -y g++-6 gcc-6 default-jdk

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 20
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-6 20
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 20
update-alternatives --install /usr/bin/cc  cc  /usr/bin/gcc-6 20

sed -i '/^deb /s/stretch/jessie/' /etc/apt/sources.list

exit 0
