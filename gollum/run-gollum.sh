#!/bin/bash

if [ ! -d wiki ]; then
  mkdir wiki
  cd wiki
  git init
fi

echo "# docker stop gollum"
docker stop gollum

echo "# docker rm gollum"
docker rm gollum

echo "# docker run -d -p 4567:4567 --name gollum -v $(pwd)/wiki:/wiki tkyonezu/gollum"
## docker run -d -p 4567:4567 --name gollum -v $(pwd)/wiki:/wiki tkyonezu/gollum
docker run -it -p 4567:4567 --name gollum -v $(pwd)/wiki:/wiki tkyonezu/gollum /bin/bash
