# frozen_string_literal: true

if defined?(Delayed::Worker)
  Delayed::Worker.destroy_failed_jobs = true
  Delayed::Worker.sleep_delay = 60
  Delayed::Worker.max_attempts = 1
  Delayed::Worker.max_run_time = 5.minutes
  Delayed::Worker.read_ahead = 10
  Delayed::Worker.default_queue_name = 'default'
  # Delayed::Worker.delay_jobs = !Rails.env.test?
  # Delayed::Worker.raise_signal_exceptions = :term
  Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed_job.log'))
end
