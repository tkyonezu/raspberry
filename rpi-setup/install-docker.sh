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

# Docker CE for Debian
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

cat <<EOR >/etc/apt-sources.list.d/docker.list
deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable
EOF

# Docker-Engine
curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

cat <<EOF >>/etc/apt/sources.list.d/docker.list
deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main
#deb [arch=armhf] https://apt.dockerproject.org/repo debian-stretch main
EOF

apt update

apt install -y docker-engine

exit 0
