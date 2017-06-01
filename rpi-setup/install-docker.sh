#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# install-docker.sh - Install Docker-Engine
#
# usage: install-docker.sh
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

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

exit 0
