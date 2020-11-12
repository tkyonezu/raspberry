#!/bin/bash

MAJOR_VERSION=v3.12
VERSION=3.12.1
ARC=armhf

if [ "$(uname -m)" = "aarch64" ]; then
  ARC=aarch64
fi

[ -d rootfs ] || mkdir rootfs

curl -fsSL https://dl-4.alpinelinux.org/alpine/${MAJOR_VERSION}/releases/${ARC}/alpine-minirootfs-${VERSION}-${ARC}.tar.gz | sudo tar -C rootfs -zxvf -

exit 0
