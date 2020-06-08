FROM ubuntu:20.04

RUN apt update

# Node.js install (https://phoenixnap.com/kb/install-latest-node-js-and-nmp-on-ubuntu)
RUN apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs
RUN apt install -y gcc g++ make

# Install Ember.js (https://guides.emberjs.com/release/getting-started/quick-start/)
RUN npm install -g ember-cli

# Prepare project's structure
RUN mkdir /web-app-ui
WORKDIR /web-app-ui
