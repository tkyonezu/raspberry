#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# install-go.sh - Install Go
#
# usage: install-go.sh
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

#
# Install Go
#
VERSION=1.8.3
OS=linux
ARCH=armv6l

cd /var/tmp

wget -N https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz

tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz

rm go$VERSION.$OS-$ARCH.tar.gz

cat >>~/.bashrc <<EOF
export GOPATH=/usr/local
export GOROOT=/usr/local/go
export PATH=\$PATH:\$GOROOT/bin
EOF

exit 0
