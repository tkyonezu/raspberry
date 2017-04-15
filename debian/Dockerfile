#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/debian - Debian stretch version
#
# build : docker build -t tkyonezu/debian .
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armhf/debian:jessie

RUN sed -i 's/jessie/stretch/' /etc/apt/sources.list

RUN apt update  && \
    apt -y upgrade

CMD ["/bin/bash"]
