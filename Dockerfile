FROM ruby:3.1.2-alpine

ENV BUNDLER_VERSION=2.3.26
ENV DOCKERIZE_VERSION v0.6.1

ENV RAILS_ENV='development'
ENV RACK_ENV='development'
ENV RAILS_ROOT /var/www/bookme

RUN apk add --update --no-cache \
    binutils-gold \
    build-base \
    curl \
    wget \
    file \
    g++ \
    gcc \
    git \
    less \
    libstdc++ \
    libffi-dev \
    libc-dev \
    linux-headers \
    libxml2-dev \
    libxslt-dev \
    libgcrypt-dev \
    postgresql-dev \
    make \
    netcat-openbsd \
    openssl \
    pkgconfig \
    postgresql-dev \
    python3 \
    tzdata \
    bash \
    imagemagick \
    nodejs \
    yarn

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

RUN gem install bundler -v ${BUNDLER_VERSION}

COPY Gemfile Gemfile.lock $RAILS_ROOT/

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install --jobs 20 --retry 5

COPY . $RAILS_ROOT/

EXPOSE 3000
