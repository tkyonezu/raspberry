#-----------------------------------------------------------------------
# mongodb - MongoDB
#
# build : docker build -t tkyonezu/mongodb .
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armhf/debian

MAINTAINER Takeshi Yonezu <tkyonezu@gmail.com>

LABEL Build="docker build -t tkyonezu/mongodb ." \
      Run="docker run -d --name mongodb -p 27017:27017 tkyonezu/mongodb"

RUN apt update && apt -y upgrade && \
    mkdir -p /data/db && \
    apt install -y mongodb-server

RUN /usr/bin/mongod &
## RUN mongo --eval "printjson(use crowi"
RUN mongo --eval "printjson(db.addUser('crowi','passw0rd'))"
RUN mongo --eval "printjson(db.shutdownServer())"

EXPOSE 27017

ENTRYPOINT ["/usr/bin/mongod"]
