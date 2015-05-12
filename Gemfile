source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2'

# Use HAML for server-side rendering
gem 'haml'
gem 'haml-rails'

gem 'simple-rss'

group :assets, :development do
  gem 'turbolinks'
  gem 'bootstrap-sass'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  #gem 'therubyracer', platforms: :ruby

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.3'
end

group :production do
  gem 'sqlite3'
end

gem 'unicorn'

# Searching plugin
gem 'elasticsearch'

# Template engine
gem 'mustache-js-rails'
