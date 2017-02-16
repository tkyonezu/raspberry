#!/bin/bash

rm -fr /run/apache2/*

exec /usr/sbin/apachectl -DFOREGROUND
