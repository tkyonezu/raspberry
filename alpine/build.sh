#!/bin/bash

VERSION=3.12.0
ARC=armhf

if [ "$(uname -m)" = "aarch64" ]; then
  ARC=aarch64
fi

sudo docker build -t ${ARC}/alpine:${VERSION} --build-arg ARC=${ARC} .

exit 0
