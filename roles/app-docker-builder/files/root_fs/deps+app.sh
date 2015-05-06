#!/bin/bash

# install dependencies
apt-get update && apt-get -qy install --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    git \
    ruby \
    ruby-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean all

# Pull in app
#git clone https://github.com/antirez/lamernews.git

#create and enter app dir
mkdir lamernews && cd lamernews

# Retrieve Gemfile
curl "https://raw.githubusercontent.com/antirez/lamernews/master/Gemfile" -o Gemfile

# Switch ruby version to latest
sed -i -e "s/ruby '1/# ruby '1/" Gemfile

# install bundler & gems
# RUN cd lamernews && gem install --no-ri --no-rdoc bundler passenger && bundle install
gem install --no-ri --no-rdoc bundler passenger && bundle install

# Setup Passenger
passenger start -d && passenger stop

# cleanup
apt-get -qy --purge autoremove \
    build-essential \
    curl \
    ruby-dev \
    && apt-get clean all
