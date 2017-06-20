#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/rocket.chat - Rocket.Chat ARMv7 version
#
# build : docker build -t tkyonezu/rocket.chat .
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armv7/armhf-ubuntu

RUN apt update  && \
    apt -y upgrade

ENV HOME=/opt/rocket.chat

RUN apt install -y build-essential curl git vim

##  git clone -b release-1.6 https://github.com/meteor/meteor.git

RUN mkdir $HOME; \
    cd $HOME; \
    git clone --depth 1 -b release-1.4-universal-beta https://github.com/4commerce-technologies-AG/meteor.git

## RUN $HOME/meteor/meteor -v

CMD ["/bin/bash"]
