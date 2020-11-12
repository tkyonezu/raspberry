#!/bin/bash

VERSION=3.12.1

sudo docker build -t alpine .
docker tag alpine alpine:${VERSION}

exit 0
