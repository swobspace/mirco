require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load dotenv only in development or test environment
if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Rails.load
end

module Mirco
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2
    if Rails.env == "development"
      config.web_console.allowed_ips = %w(10.0.0.0/8 192.168.0.0/16)
      config.web_console.permissions = %w(10.0.0.0/8 192.168.0.0/16)
    end

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks capistrano templates))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = ENV['TZ'] || 'Berlin'

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.after_initialize do
      Rails.application.reload_routes!
    end
    unless Rails.env.test?
      config.active_job.queue_adapter = :good_job
      config.active_job.queue_name_prefix = "mirco_#{Rails.env}"
    end
    config.responders.error_status = :unprocessable_entity
    config.responders.redirect_status = :see_other
  end
end
