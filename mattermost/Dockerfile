#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# tkyonezu/mattermost - Mattermost ARMv7 version
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

SHELL ["/bin/bash", "-c"]

# Update Linux and Install tools
RUN apt update && \
    apt -y upgrade && \
    apt install -y build-essential libssl-dev curl git vim npm wget

ENV GOPATH=/usr/local
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin

# Install Go
RUN cd /var/tmp; \
    wget -N https://storage.googleapis.com/golang/go1.8.3.linux-armv6l.tar.gz; \
    tar -C /usr/local -xzf go1.8.3.linux-armv6l.tar.gz; \
    rm go1.8.3.linux-armv6l.tar.gz; \
    echo export GOPATH=$GOPATH >>~/.bashrc; \
    echo export GOROOT=$GOROOT >>~/.bashrc; \
    echo export PATH=\$PATH:\$GOROOT/bin >>~/.bashrc

# Install npm, nodejs
RUN wget -N https://nodejs.org/dist/v6.11.0/node-v6.11.0-linux-armv7l.tar.xz; \
    tar -C /usr/local -Jxvf node-v6.11.0-linux-armv7l.tar.xz; \
    echo "\$PATH=\$PATH:/usr/local/node-v6.11.0-linux-armv7l/bin" >>~/.bashrc

## RUN apt install -y npm; \
##     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash; \
##     NVM_DIR="/root/.nvm"; \
##     [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
##     nvm install 5.5.0

# Install ruby, compass
RUN apt update && \
    apt install -y git-core curl zlib1g-dev build-essential libssl-dev \
      libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
      libxslt1-dev libcurl4-openssl-dev python-software-properties libgdm-dev \
      libncurses5-dev automake libtool bison libffi-dev gnupg

RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -; \
    curl -L https://get.rvm.io | bash -s stable; \
    source /etc/profile.d/rvm.sh; \
    echo "source /etc/profile.d/rvm.sh" >>~/.bashrc; \
    rvm install 2.4.0; \
    rvm use 2.4.0 --default; \
    ruby -v; \
    gem install compass

# Install yarn
## RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN wget https://nodejs.org/dist/v6.11.0/node-v6.11.0-linux-armv7l.tar.xz; \
    tar zxvf -C /usr/local node-v6.11.0-linux-armv7l.tar.xz

# Build Mattermost
RUN source ~/.bashrc; \
    go get github.com/kr/godep; \
    mkdir -p $GOPATH/src/github.com/mattermost/platform; \
    git clone https://github.com/mattermost/platform $GOPATH/src/github.com/mattermost/platform

##  cd $GOPATH/src/github.com/mattermost/platform; \
##  make dist
##  make build

CMD ["/bin/bash"]
