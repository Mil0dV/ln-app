# AUTHOR:         Milo de Vries <milo@xdh.nl
# DESCRIPTION:    Ruby+Lamernews setup

FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# install dependencies
RUN apt-get update && apt-get -y install --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    git \
    ruby \
    ruby-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean all

# Pull in app
RUN git clone https://github.com/antirez/lamernews.git

# install bundler & gems
RUN cd lamernews && gem install --no-ri --no-rdoc bundler passenger && bundle install

# Set Redis IP
COPY redis_host /
# RUN sed -i -e 's/127.0.0.1:10000/`cat redis_host`:6379/' lamernews/app_config.rb

# CMD cd lamernews && bundle exec rackup -p8080 --host 0.0.0.0
CMD cd lamernews && passenger start --port 8080

EXPOSE 8080
