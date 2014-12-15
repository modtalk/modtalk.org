source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

# Use HAML for server-side rendering
gem 'haml'
gem 'haml-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.3'
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'mysql2'
end

gem 'thin'

# Searching plugin
gem 'elasticsearch'

# Template engine
gem 'mustache-js-rails'
