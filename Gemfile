source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.1'

# Use HAML for server-side rendering
gem 'haml'
gem 'haml-rails'

gem 'simple-rss'
gem 'tzinfo-data'

# Gems used only for assets and not required
# in production environments by default.
group :assets, :development do
  gem 'turbolinks'
  gem 'bootstrap-sass'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  # Use SCSS for stylesheets
  gem 'sass-rails'

  # Template engine
  gem 'mustache-js-rails'
end

group :development, :production do
  gem 'sentry-raven'
end

group :production do
  gem 'mysql2'
end

gem 'unicorn'

# Searching plugin
gem 'elasticsearch'
