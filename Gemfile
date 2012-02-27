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
# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'devise'
gem 'will_paginate'
gem 'carrierwave'
gem 'stripe'

group :development, :testing do
  gem 'capybara'
  gem 'guard'
  gem 'guard-rake'
  gem 'growl'
  gem 'launchy'
  gem 'ruby_gntp' 
end

# for all you ruby-debug haters out there
begin
  if (Gem::Specification::find_by_name "ruby-debug-base19", ">= 0.11.26")
    source 'https://gems.gemfury.com/8n1rdTK8pezvcsyVmmgJ/'
    gem 'linecache19',       '>= 0.5.13'
    gem 'ruby-debug-base19', '>= 0.11.26'
    gem 'ruby-debug19'
  end
rescue Gem::LoadError
  puts "no debug for you"
end
