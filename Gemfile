source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
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
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'simple_form'
gem 'rails-i18n', '~> 6.0.0'
gem 'font-awesome-sass', '>=4.7', '< 6'
gem 'view_component', require: "view_component/engine"
gem 'hotwire-rails'

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'libnotify'
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-yarn'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-puma'
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
  gem 'capybara'
  gem 'apparition'
  gem 'launchy'
end

gem 'cancancan'
gem 'simple_form'
gem 'wobauth', git: 'https://github.com/swobspace/wobauth.git', branch: 'develop'
gem 'wobapphelpers', git: 'https://github.com/swobspace/wobapphelpers', branch: 'develop'
gem 'wobmire', git: 'https://github.com/swobspace/wobmire', branch: 'master'
gem 'lockbox'
gem 'asciidoctor'
gem 'pp'
gem 'sidekiq'
gem 'sidekiq-scheduler'

# workaround for faraday-net_http
gem "net-http"

