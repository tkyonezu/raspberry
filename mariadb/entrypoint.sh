#!/bin/bash

#-----------------------------------------------------------------------
# Function      : MariaDB initial
#
# Syntax        : entrypoint.sh
#
# Author        : Takeshi Yonezu <tkyonezu@gmail.com>
#
# Copyright (c) 2016, 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
# No   Date       Author       Change History
#-----------------------------------------------------------------------
# 0002 2017/06/15 T.Yonezu     Adopt Ubuntu 16.04 LTS version
# 0001 2016/04/03 T.Yonezu     First Release
#-----------------------------------------------------------------------

# Start MariaDB Server
[ -d /var/run/mysqld ] || mkdir /var/run/mysqld && \
  chown mysql:mysql /var/run/mysqld

/usr/bin/mysqld_safe --basedir=/usr &

mysqladmin -u root password 'passw0rd'

mysql_secure_installation <<EOF
passw0rd
n




EOF

#
# MariaDB
#
cat <<EOF >>/var/tmp/mariadb.sql
# Security Enhancement
delete from mysql.user where user='' or (user='root' and host != 'localhost');
# Create Database and User for ownCloud
create database owncloud character set utf8;
grant all privileges on owncloud.* to owncloud@'172.17.0.%' identified by 'passw0rd';
# Create Database and User for WordPress
create database wordpress character set utf8;
grant all privileges on wordpress.* to wordpress@'172.17.0.%' identified by 'passw0rd';
# Flush modifications
flush privileges;
EOF

mysql -uroot -ppassw0rd </var/tmp/mariadb.sql

rm /var/tmp/mariadb.sql

exit 0
