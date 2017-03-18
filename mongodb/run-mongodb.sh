#!/bin/bash

echo "# docker stop mongodb"
docker stop mongodb

echo "# docker rm mongodb"
docker rm mongodb

echo "# docker run -d --name mongodb -p 27017:27017 -v $(pwd)/db:/data/db tkyonezu/mongodb"

docker run -d --name mongodb -p 27017:27017 \
  -v $(pwd)/db:/data/db \
  tkyonezu/mongodb
