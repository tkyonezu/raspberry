ARG ARC=armhf

FROM ${ARC}/alpine

ADD rootfs /

RUN apk update \
 && apk upgrade

CMD /bin/sh
