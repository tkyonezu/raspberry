#-----------------------------------------------------------------------
# gollum - A simple, Git-powered wiki with a sweet API and local frontend.
#
# build : docker build -t tkyonezu/gollum .
#
# Copyright (c) 2017 Takeshi Yonezu <tkyonezu@gmail.com>
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM armhf/debian

MAINTAINER Takeshi Yonezu <tkyonezu@gmail.com>

RUN apt update && apt -y upgrade
RUN apt install -y build-essential make ruby2.1 rubygems ruby-dev \
        libicu-dev zlib1g-dev cmake pkg-config git && \
    rm -rf /var/lib/apt/lists*
RUN gem install github-linguist && \
    gem install gollum && \
    gem install org-ruby

COPY run.rb /

WORKDIR /wiki

EXPOSE 4567

CMD ["ruby", "/run.rb", "/wiki"]
