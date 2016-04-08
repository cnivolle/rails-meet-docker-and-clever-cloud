# -*- sh -*-
FROM fcat/ubuntu-universe:12.04

# development tools
RUN apt-get -qy install git vim tmux

# ruby 1.9.3 and build dependencies
RUN apt-get -qy install ruby1.9.1 ruby1.9.1-dev build-essential libpq-dev libv8-dev libsqlite3-dev

# bundler
RUN gem install bundler

# create a "rails" user
# the Rails application will live in the /rails directory
RUN adduser --disabled-password --home=/rails --gecos "" rails



#Datadog
docker run -d --name dd-agent -h `hostname` -v /var/run/docker.sock:/var/run/docker.sock -v /proc/:/host/proc/:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=64b9c0afcea4940746506697bd9849f4 datadog/docker-dd-agent:latest

# copy the Rails app
# we assume we have cloned the "docrails" repository locally
#  and it is clean; see the "prepare" script
ADD rails /rails

RUN chown rails -R /rails

# copy and execute the setup script
# this will run bundler, setup the database, etc.
ADD scripts/setup /setup
RUN su rails -c /setup

# copy the start script
ADD scripts/start /start

EXPOSE 8080
USER rails
CMD /start
