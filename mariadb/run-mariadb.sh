#!/bin/bash

export LANG=en_US.utf8

#
# MariaDB
#
echo "# docker stop mariadb"
docker stop mariadb

echo "# docker rm mariadb"
docker rm mariadb

echo "# docker run -d --name mariadb -p 3306:3306 -v $(pwd)/var/lib/mysql:/var/lib/mysql tkyonezu/local/mariadb"

docker run -it --name mariadb -p 3306:3306 \
  -v /etc/localtime:/etc/localtime:ro \
  -v $(pwd)/var/lib/mysql:/var/lib/mysql \
  tkyonezu/mariadb \
  /bin/bash

exit 0
