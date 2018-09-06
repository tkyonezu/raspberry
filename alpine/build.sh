#!/bin/bash

VERSION=3.8.0

sudo docker build -t armhf/alpine:${VERSION} .

exit 0
