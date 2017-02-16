#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/debian - Debian stretch version
#
# build : docker build -t tkyonezu/debian .
#
# Copyright (c) 2017 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armhf/debian

RUN sed -i 's/jessie/stretch/' /etc/apt/sources.list

RUN apt update  && \
    apt -y upgrade

CMD ["/bin/bash"]
