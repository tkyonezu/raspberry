#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/owncloud - ownCloud ARMv7 version
#
# build : docker build -t tkyonezu/mattermost .
#
# https://docs.mattermost.com/developer/dev-setup-ubuntu-1604.html
# https://docs.mattermost.com/developer/dev-setup-compiling.html
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armv7/armhf-ubuntu

# Update Linux and Install tools
RUN sed -i 's/ports.ubuntu.com/jp.archive.ubuntu.com/' /etc/apt/sources.list && \
    apt update && \
    apt -y upgrade

RUN apt install -y wget bzip2 apache2 \
      libapache2-mod-php php-gd php-json php-mysql \
      php-curl php-intl php-mcrypt php-imagick \
      php-zip php-xml php-mbstring

RUN wget https://download.owncloud.org/community/owncloud-10.0.2.tar.bz2 && \
    tar jxf owncloud-10.0.2.tar.bz2 && rm owncloud-10.0.2.tar.bz2 && \
    cp -r owncloud /var/www && rm -fr owncloud

COPY owncloud.conf /etc/apache2/sites-available

RUN ln -s /etc/apache2/sites-available/owncloud.conf /etc/apache2/sites-enabled/owncloud.conf && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod env && \
    a2enmod dir && \
    a2enmod mime

COPY init.sh /usr/local/bin/init.sh
RUN chmod u+x /usr/local/bin/init.sh; \
    chown 33:33 /var/www/owncloud /var/www/owncloud/config /var/www/owncloud/apps

# Expose ownCloud Server port 80/tcp
EXPOSE 80

# Start ownCloud Server (MariaDB Server, Apache Web Server)
CMD ["/usr/local/bin/init.sh"]
## CMD ["/bin/bash"]
