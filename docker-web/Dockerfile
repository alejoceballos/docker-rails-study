FROM ruby:2.7

# Prepare to install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs
RUN apt-get install -y yarn

RUN apt-get install -y postgresql-client

RUN mkdir /web-app-api

WORKDIR /web-app-api
COPY Gemfile /web-app-api/Gemfile
COPY Gemfile.lock /web-app-api/Gemfile.lock

RUN bundle install

COPY . /web-app-api
