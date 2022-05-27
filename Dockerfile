# syntax=docker/dockerfile:1
FROM ruby:3.1.2-bullseye

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

WORKDIR /usr/src/app

COPY Gemfile* /usr/src/app
RUN bundle install

COPY . /usr/src/app

CMD ["bin/rails", "s", "--binding", "0.0.0.0"]
