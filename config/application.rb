require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mirco
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = 'Berlin'

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.after_initialize do
      Rails.application.reload_routes!
    end
    unless Rails.env.test?
      config.active_job.queue_adapter = :delayed_job
      config.active_job.queue_name_prefix = "mirco_#{Rails.env}"
    end
  end
end
