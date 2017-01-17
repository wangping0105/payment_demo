# source 'https://rubygems.org'
source 'https://gems.ruby-china.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

#//分页
gem 'kaminari'
# auth 解决方案
gem 'devise'
# gem 'chinese_pinyin'
gem 'ruby-pinyin', '~> 0.4.7'
# 定时任务 config/schedule.rb
gem 'whenever', require: false

gem 'sidekiq', '~> 3.4.1'

gem 'rails_admin', '~> 1.0'
# 软删除
gem 'paranoia', git: 'https://github.com/rubysherpas/paranoia.git', branch: 'core'
# filepath
gem 'paperclip', '~> 4.3.1'
# Use jquery as the JavaScript library
gem 'jquery-validation-rails', '~> 1.16.0'

gem 'geocoder', '~> 1.2.12'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'guard'
  gem 'guard-rspec'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

  gem 'spring'

  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Use Capistrano for deployment 自动化部署
group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code. Read more: https://github.com/rails/web-console
  gem 'web-console'

  # The Listen gem listens to file modifications and notifies you about the changes. Read more: https://github.com/guard/listen
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Makes spring watch files using the listen gem. Read more: https://github.com/jonleighton/spring-watcher-listen
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Better error page for Rack apps. Read more: https://github.com/charliesome/better_errors
  gem 'better_errors', '2.1.1'

  # Retrieve the binding of a method's caller in MRI 1.9.2+. Read more: https://github.com/banister/binding_of_caller
  gem 'binding_of_caller', '0.7.2'

  # Capistrano: A deployment automation tool built on Ruby, Rake, and SSH. Read more: https://github.com/capistrano/capistrano
  gem 'capistrano', '~> 3.5'

  # RVM support for Capistrano v3: https://github.com/capistrano/rvm
  gem 'capistrano-rvm'

  # Puma integration for Capistrano https://github.com/seuros/capistrano-puma
  gem 'capistrano3-puma'

  # Bundler support for Capistrano 3.x https://github.com/capistrano/bundler
  gem 'capistrano-bundler', '~> 1.1.4'

  # Rails specific tasks for Capistrano v3: https://github.com/capistrano/rails
  gem 'capistrano-rails'

  gem 'capistrano-sidekiq'

  # Patch-level verification for Bundler. Read more: https://github.com/rubysec/bundler-audit
  gem 'bundler-audit', '0.5.0'
end

# Use unicorn as the app server
group :production do
  gem 'unicorn'
  gem "unicorn-worker-killer"
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
