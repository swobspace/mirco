# config/initializers/good_job.rb
# STDOUT.sync = true
$stdout.sync = true

Rails.application.configure do
  config.good_job = {
    execution_mode: :external,
    enable_cron: true,
    max_threads: 4,
    poll_interval: 30,
    retry_on_unhandled_error: false,
    preserve_job_records: true,
    # cleanup_interval_jobs: 100,
    cleanup_interval_seconds: 3600,
    cleanup_preserved_jobs_before_seconds_ago: 172800,
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
end
