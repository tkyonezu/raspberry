#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3B, 3B+, 4B
#
# install-docker.sh - Install Docker-Engine
#
# usage: install-docker.sh
#
# Copyright (c) 2017-2021 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

#
# Install Docker
#
logmsg "Install Docker"

OS=$(uname -s)
ARCH=$(uname -m)

case ${OS} in
  Linux)  OS=linux;;
  Darwin) echo "${OS}/${ARCH} can use Docker for Mac."; exit 1;;
  *) echo "${OS}-${ARCH} does'nt supported yet."; exit 1;;
esac

DIST=$(cat /etc/os-release | grep ^ID= | sed 's/^ID=//')

case ${ARCH} in
  x86_64) ARCH=amd64;;
  armv7l) ARCH=armhf;;
  aarch64) ARCH=arm64;;
  *) echo "${OS}-${ARCH} does'nt supported yet."; exit 1;;
esac

apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

if [ -f /usr/share/keyrings/docker-archive-keyring.gpg ]; then
  rm /usr/share/keyrings/docker-archive-keyring.gpg
fi

curl -fsSL https://download.docker.com/linux/${DIST}/gpg |
  sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

cat <<EOF >/etc/apt/sources.list.d/docker.list
deb [arch=${ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/${DIST} $(lsb_release -cs) stable
EOF

apt update

apt install -y docker-ce docker-ce-cli containerd.io

exit 0
