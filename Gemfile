source 'https://rubygems.org'
ruby '2.2.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
# search competencies
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
gem 'searchkick'
gem 'will_paginate', '~> 3.0.6'
# Random generator
gem 'faker'
gem 'bazaar'
# securing the API keys
gem 'dotenv-rails', groups: [:development]
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'best_in_place'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'fastclick-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Uses Private_Pub for a realtime feed
gem 'private_pub'

# Use Unicorn as the app server
# gem 'unicorn'
gem 'remotipart'
gem 'paperclip'
gem 'aws-sdk', '< 2.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# TODO: neccessary?
gem 'thin'
