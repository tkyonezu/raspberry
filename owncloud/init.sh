#!/bin/bash

#-----------------------------------------------------------------------
# Function      : ownCloud initial
#
# Syntax        : init.sh
#
# Author        : Takeshi Yonezu <tkyonezu@gmail.com>
#
# Copyright (c) 2016 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
# No   Date       Author       Change History
#-----------------------------------------------------------------------
# 0002 2016/03/19 T.Yonezu     copy eplite initial modify for ownCloud
# 0001 2016/02/10 T.Yonezu     First Release
#-----------------------------------------------------------------------

## # First time create DB
## if [ ! -d /var/lib/mysql/owncloud ]; then
## ##  mysqladmin -u root password 'passw0rd'
##   cat <<EOF >/tmp/owncloud.sql
## DELETE FROM mysql.user WHERE user = '' or ( user = 'root' AND host != 'localhost' );
## FLUSH PRIVILEGES;
## CREATE DATABASE owncloud CHARACTER SET utf8;
## GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'%' IDENTIFIED BY 'passw0rd';
## FLUSH PRIVILEGES;
## SELECT user, password, host FROM mysql.user;
## EOF
##   mysql -h mariadb.nttdg.jp -uroot -ppassw0rd </tmp/owncloud.sql
## fi

# Save/Restore config.php for ownCloud
if [ ! -d /var/www/owncloud/config ]; then
  mkdir /var/www/owncloud/config
  chown www:www /var/www/owncloud/config
  chmod 775 /var/www/owncloud/config
fi

if [[ -f /var/www/owncloud/config/config.php && ! -f /var/lib/owncloud/config/config.php ]]; then
  mkdir -p /var/lib/owncloud/config
  cp -p /var/www/owncloud/config/config.php /var/lib/owncloud/config
  chown -R www:www /var/lib/owncloud
  chmod 640 /var/lib/owncloud/config/config.php
fi

if [[ ! -f /var/www/owncloud/config/config.php && -f /var/lib/owncloud/config/config.php ]]; then
  cp -p /var/lib/owncloud/config/config.php /var/www/owncloud/config
fi

# Start Apache Web Server
[ -d /var/run/apache2 ] || mkdir /var/run/apache2 && \
  chown www:www /var/run/apache2

## if ! grep -q VirtualHost /etc/apache2/conf.d/owncloud.conf; then
## cat <<EOF >>/etc/httpd/conf.d/owncloud.conf
## 
## <VirtualHost *:80>
##     DocumentRoot /var/www/owncloud
##     ServerName 172.17.0.2
## </VirtualHost>
## EOF
## fi

rm -f /var/run/apache2/httpd.pid

/usr/sbin/apache2 -DFOREGROUND
