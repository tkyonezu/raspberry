#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/mariadb - MariaDB 5.5 ARMv7 version
#
# build : docker build -t tkyonezu/mariadb .
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armv7/armhf-ubuntu

RUN apt update && \
    apt -y upgrade

RUN apt install -y  mariadb-server

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod u+x /usr/local/bin/entrypoint.sh && \
    chown 101:101 /var/lib/mysql

VOLUME /var/lib/mysql

USER 101

EXPOSE 3306

## CMD /usr/local/bin/entrypoint.sh && tail -f /dev/null
CMD ["mysqld_safe"]
