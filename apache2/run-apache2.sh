#!/bin/bash

echo "# docker stop apache2"
docker stop apache2

echo "# docker rm apache2"
docker rm apache2

echo "# docker run -d -p80:80 --name apache2 tkyonezu/apache2"
docker run -d -p80:80 --name apache2 tkyonezu/apache2
