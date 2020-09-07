#!/bin/bash

VERSION=3.12.0

sudo docker build -t armhf/alpine:${VERSION} .

exit 0
