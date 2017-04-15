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

RUN sed -i 's/jessie/stretch/' /etc/apt/sources.list && \
    apt update && apt -y upgrade

RUN apt install -y build-essential make ruby2.3 rubygems ruby-dev \
        libicu-dev zlib1g-dev cmake pkg-config git && \
    rm -rf /var/lib/apt/lists*

RUN gem install grit && \
    gem install github-linguist && \
    gem install gollum && \
    gem install org-ruby

COPY entrypoint.rb /

WORKDIR /wiki

EXPOSE 4567

CMD ["ruby", "/entrypoint.rb", "/wiki"]
