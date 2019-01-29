#!/bin/bash

VERSION=3.8.2

sudo docker build -t armhf/alpine:${VERSION} .

exit 0
