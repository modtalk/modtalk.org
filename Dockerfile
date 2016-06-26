FROM ubuntu:16.04

RUN /usr/bin/apt-get update \
  && /usr/bin/apt-get install --no-install-recommends -qy ruby ruby-dev make g++ libsqlite3-dev libsqlite3-0 patch zlib1g-dev zlib1g \
  && gem install bundler --no-ri --no-rdoc
ADD Gemfile /rails-app/Gemfile
ADD Gemfile.lock /rails-app/Gemfile.lock
WORKDIR /rails-app
RUN /usr/bin/env bundle install --without assets development test \
 && /usr/bin/apt-get -qy remove --purge ruby-dev g++ make patch gcc zlib1g-dev \
 && /usr/bin/apt-get -qy autoremove \
 && /usr/bin/dpkg --purge `dpkg --get-selections | grep deinstall | cut -f1` \
 && apt-get clean \
 && /bin/rm -rf /var/lib/gems/2.1.0/cache -rf /var/cache -rf /var/lib/apt/lists -rf /var/log/*
ADD . /rails-app
RUN find public -mindepth 1 -not -name 'assets' -not -name 'manifest-*.json' -delete
RUN chown -R www-data:www-data Gemfile.lock db tmp
USER www-data
EXPOSE 8080
CMD bundle exec unicorn -p 8080
