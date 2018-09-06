#!/bin/bash

MAJOR_VERSION=v3.8
VERSION=3.8.0

[ -d rootfs ] || mkdir rootfs

curl -fsSL https://dl-4.alpinelinux.org/alpine/${MAJOR_VERSION}/releases/armhf/alpine-minirootfs-${VERSION}-armhf.tar.gz | sudo tar -C rootfs -zxvf -

exit 0
