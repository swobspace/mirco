source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'simple_form'
gem 'rails-i18n', '~> 6.0.0'
gem 'font-awesome-sass', '>=4.7', '< 6'
gem 'view_component'
gem 'hotwire-rails'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-yarn'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rails'
  gem 'guard-bundler'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'dotenv'
  gem 'guard-rspec', require: false
  gem 'railroady'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'factory_bot_rails'
  gem 'database_rewinder'
  gem 'capybara'
  gem 'apparition'
  gem 'launchy'
end

group :production do
  gem 'mysql2'
end
gem 'cancancan'
gem 'wobauth', git: 'https://github.com/swobspace/wobauth.git', branch: 'develop'
gem 'simple_form'
gem 'wobapphelpers', git: 'https://github.com/swobspace/wobapphelpers', branch: 'develop'
gem 'lockbox'
