#!/bin/bash

docker stop owncloud
docker rm owncloud

# -v $(pwd)/var/lib/mysql:/var/lib/mysql \

docker run -it --name owncloud -p80:80 \
  -v /etc/localtime:/etc/localtime:ro \
  -v $(pwd)/var/www/owncloud/apps:/var/www/owncloud/apps \
  -v $(pwd)/var/www/owncloud/config:/var/www/owncloud/config \
  -v $(pwd)/var/www/owncloud/data:/var/www/owncloud/data \
  -v $(pwd)/var/lib/owncloud:/var/lib/owncloud \
  tkyonezu/owncloud
