FROM ubuntu:16.04

RUN apt-get update && apt-get -y install \
  build-essential \
  git \
  libcurl4-openssl-dev \
  liblzma-dev \
  libmysqld-dev \
  libpq-dev \
  libsqlite3-dev \
  nodejs \
  rbenv \
  ruby-build \
  ruby-dev \
  tzdata \
  zlib1g-dev

ARG RUBY_VERSION=2.3.1
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN rbenv install ${RUBY_VERSION} && rbenv global ${RUBY_VERSION}
ENV PATH /root/.rbenv/shims:$PATH

ARG BUNDLER_VERSION=1.14.6
RUN gem install bundler -v ${BUNDLER_VERSION} && rbenv rehash

WORKDIR /app
COPY conf/convox.rb /app/config/initializers/convox.rb

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
