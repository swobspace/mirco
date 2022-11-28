# config/initializers/good_job.rb
# STDOUT.sync = true
$stdout.sync = true

Rails.application.configure do
  if Rails.env == 'development'
    if ENV['GOOD_JOB_EXECUTION_MODE']
      config.good_job.execution_mode = ENV['GOOD_JOB_EXECUTION_MODE'].to_sym
    elsif Rails.const_defined?("Server")
      config.good_job.execution_mode = :async_server
    elsif Rails.const_defined?("Console")
      config.good_job.execution_mode = :external
    end
  else
    config.good_job.execution_mode = :async_server
  end

  config.good_job = {
    enable_cron: true,
    max_threads: 4,
    poll_interval: 30,
    retry_on_unhandled_error: false,
    preserve_job_records: false,

    cron: {
      fetch_statistics: {
        cron: Mirco.cron_expression,
        class: "Channels::FetchStatisticsJob",
        description: "Fetch current channel statistics from all servers"
      },
      fetch_channels: {
        cron: '0 1 * * 6',
        class: "Channels::FetchJob",
        description: "Update channel configurations from all servers"
      }
    }
  }
end

if defined? PhusionPassenger
  PhusionPassenger.on_event :starting_worker_process do |forked|
    # If `forked` is true, we're in smart spawning mode.
    # https://www.phusionpassenger.com/docs/advanced_guides/in_depth/ruby/spawn_methods.html#smart-spawning-hooks
    if forked
      GoodJob.logger.info { 'Starting Passenger worker process.' }
      GoodJob.restart
    end
  end

  PhusionPassenger.on_event :stopping_worker_process do
    GoodJob.logger.info { 'Stopping Passenger worker process.' }
    GoodJob.shutdown
  end
end

# GoodJob also starts in the Passenger preloader process. This one does not
# trigger the above events, thus we catch it with `Kernel#at_exit`.
PRELOADER_PID = Process.pid
at_exit do
  if Process.pid == PRELOADER_PID
    GoodJob.logger.info { 'Passenger AppPreloader shutting down.' }
    GoodJob.shutdown
  end
end
