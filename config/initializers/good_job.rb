# config/initializers/good_job.rb
# STDOUT.sync = true
$stdout.sync = true

Rails.application.configure do
  config.good_job = {
    execution_mode: :async_server,
    enable_cron: true,
    max_threads: 4,
    poll_interval: 30,
    retry_on_unhandled_error: false,
    preserve_job_records: false,

    cron: {
      fetch_statistics: {
        cron: Mirco.cron_fetch_statistics,
        class: "Channels::FetchStatisticsJob",
        description: "Fetch current channel statistics from all servers"
      },
      fetch_channels: {
        cron: Mirco.cron_fetch_channels,
        class: "Channels::FetchJob",
        description: "Update channel configurations from all servers"
      },
      fetch_configuration: {
        cron: Mirco.cron_fetch_configuration,
        class: "Servers::FetchConfigurationJob",
        description: "Fetch server configurations as backup"
      },
      purge_timescale: {
        cron: Mirco.cron_purge_timescale,
        class: "Mirco::PurgeTimescaleJob",
        description: "Purge Timescale Hypertables outdated data"
      }
    }
  }

  if ENV['GOOD_JOB_EXECUTION_MODE']
    config.good_job[:execution_mode] = ENV['GOOD_JOB_EXECUTION_MODE'].to_sym
  elsif Rails.const_defined?("Console")
    config.good_job[:execution_mode] = :external
  elsif Rails.const_defined?("Server")
    case Rails.env
    when 'development', 'production'
      config.good_job[:execution_mode] = :external
    when 'test'
      config.good_job[:execution_mode] = :inline
    else
    end
  end
end
