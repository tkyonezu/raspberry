#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/devian - Debian stretch version
#
# build : docker build -t tkyonezu/debian .
#
# Copyright (c) 2017 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM tkyonezu/debian:stretch

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL Vendor="Soramitsu,Co.,Ltd." \
      License="Apache License, Version 2.0" \
      Version=2.4.10-10+deb8u7 \
      Build="docker build -t tkyonezu/apache2 ." \
      Run="docker run -d --name apache2 -p80:80 tkyonezu/apache2"

RUN apt update  && \
    apt -y upgrade && \
    apt -y install apache2

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
