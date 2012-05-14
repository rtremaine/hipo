source 'https://rubygems.org'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
gem 'devise'
gem 'will_paginate'
gem 'carrierwave'
gem 'stripe'
gem 'mini_magick'
gem 'formtastic-bootstrap'
gem 'gravtastic'
gem 'cancan'
gem 'comma'
gem 'browser'
gem 'exception_notifier'

group :development, :testing do
  gem 'capybara'
  gem 'guard'
  gem 'guard-rake'
  gem 'growl'
  gem 'launchy'
  gem 'ruby_gntp' 
  gem 'turn'
  gem 'minitest'
  gem 'mail_safe'
end

# for all you ruby-debug haters out there
# to enable follow this woderful tutorial http://blog.ryantremaine.com/2012/04/conditionally-load-ruby-debug-gem.html
begin
  if (Gem::Specification::find_by_name "ruby-debug-base19", ">= 0.11.26")
    gem 'linecache19',       '>= 0.5.13'
    gem 'ruby-debug-base19', '>= 0.11.26'
    gem 'ruby-debug19'
  end
rescue Gem::LoadError
  puts "no debug for you"
end
