FROM ubuntu:19.04

ADD . /rails-app
WORKDIR /rails-app
RUN export DEV_PKGS="libmysqlclient-dev zlib1g-dev libghc-zlib-dev ruby-dev g++ make patch" \
  && apt-get update \
  && apt-get install --no-install-recommends -qy ruby libmysqlclient20 $DEV_PKGS \
  && gem install bundler rake --no-ri --no-rdoc \
  && env bundle install --without test development \
  # Generate compiled assets + manifests
  && RAILS_ENV=assets rake assets:precompile \
  # Uninstall development headers/packages
  && apt-get -qy purge $DEV_PKGS \
  && apt-get -qy autoremove \
  && rm -rf /var/lib/gems/2.3.0/cache /var/cache/* /root /var/lib/apt/info/* /var/lib/apt/lists/* \
     tmp/* \
  # All files/folders should be owned by root by readable by www-data
  && find . -type f -print -exec chmod 444 {} \; \
  && find . -type d -print -exec chmod 555 {} \; \
  && chown -R www-data:www-data tmp \
  && chmod 755 db && find tmp -type d -print -exec chmod 755 {} \; \
  && find bin -type f -print -exec chmod 544 {} \;
ENV RAILS_ENV=production
USER www-data
EXPOSE 8080
ENTRYPOINT ["/usr/bin/ruby", "/rails-app/bin/bundle", "exec"]
CMD ["/usr/local/bin/unicorn", "-o", "0.0.0.0", "-p", "8080", "--no-default-middleware"]
