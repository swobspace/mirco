# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>=2.7.3'

gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.1.0'
gem "sprockets-rails"
# gem 'sassc-rails', require: false
gem 'redis', '~> 5.0'

gem 'bootsnap', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'rails-i18n', '~> 7.0.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'view_component'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rails', require: false
  gem 'capistrano-yarn'
  gem 'guard'
  # gem 'guard-bundler'
  gem 'guard-livereload', require: false
  # gem 'guard-puma'
  gem 'libnotify'
  gem 'listen', '~> 3.3'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console', '>= 4.1.0'
end

group :test, :development do
  gem 'dotenv'
  gem 'guard-rspec', require: false
  gem 'railroady'
  gem 'rspec-rails', '>= 6.0.3'
  # gem 'rspec-core', github: 'rspec/rspec-core', branch: 'main'
  # gem 'rspec-mocks', github: 'rspec/rspec-mocks', branch: 'main'
  # gem 'rspec-support', github: 'rspec/rspec-support', branch: 'main'
  # gem 'rspec-expectations', github: 'rspec/rspec-expectations', branch: 'main'
  # gem 'rspec-rails', github: 'rspec/rspec-rails', branch: 'main'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdriver'
  gem 'launchy'
end

gem 'asciidoctor'
gem 'cancancan'
gem 'lockbox'
gem 'pp'
gem 'simple_form'
gem 'wobapphelpers', git: 'https://github.com/swobspace/wobapphelpers', branch: 'master'
gem 'wobauth', git: 'https://github.com/swobspace/wobauth.git', branch: 'master'
gem 'wobmire', git: 'https://github.com/swobspace/wobmire', branch: 'master'
gem 'wobaduser'

# gem 'sidekiq'
# gem 'sidekiq-scheduler'
gem 'daemons'

# workaround for faraday-net_http
gem 'net-http'

gem 'chartkick', '~> 5.0'
gem 'draper'
gem 'kramdown'
# gem 'uri', '0.10.0'

gem 'responders'

gem 'jsbundling-rails'
gem 'cssbundling-rails'

gem "rails-controller-testing", "~> 1.0"

gem "devise-remote-user", "~> 1.1"

gem "faker", "~> 3.1"

gem "good_job", "~> 4.1.0"

# for deployment
gem "ed25519"
gem "bcrypt_pbkdf"

# workaround
#gem "mail"

# gem 'rubyzip', '~> 3.0'
gem 'rubyzip', github: 'rubyzip/rubyzip', branch: 'master'

gem 'net-ping'
