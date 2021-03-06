FROM  ruby:2.6.1-alpine3.9
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LC_CTYPE="utf-8"
ENV WORK_DIR="/qoota" \
    CONTAINER_ROOT="./" \
    NOKOGIRI_OPTION="--use-system-libraries \
                    --with-xml2-config=/usr/bin/xml2-config \
                    --with-xslt-config=/usr/bin/xslt-config" \
    MYSQL_PORT=4306 \
    SERVER_PORT=3000
RUN apk update \
 && apk upgrade --no-cache \
 && apk add --update --no-cache \
      alpine-sdk \
      bash \
      jq \
      less \
      libgcrypt-dev \
      libxml2-dev \
      libxslt-dev \
      mariadb-dev \
      mysql-client \
      nodejs \
      tzdata \
      yarn \
      xvfb \
#  && apk add --update --no-cache \
      build-base \
      wget \
      yaml-dev \
      zlib-dev \
 && gem install -q -N bundler \
 && gem install -q -N pkg-config \
 && gem install -q -N rails -v 5.2.3 \
 && gem install -q -N nokogiri -v 1.10.2 -- $NOKOGIRI_OPTION \
 && gem install -q -N mysql2 -v 0.5.2
WORKDIR $WORK_DIR
COPY Gemfile Gemfile.lock $CONTAINER_ROOT
RUN bundle install --jobs=4 --retry=3
ENV RAILS_SERVE_STATIC_FILES=true \
    PORT=$SERVER_PORT \
    TERM=xterm
EXPOSE $SERVER_PORT
EXPOSE $MYSQL_PORT