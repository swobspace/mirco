Rails.application.configure do
  unless Rails.env == 'test'
    config.active_job.queue_adapter = :delayed_job
    config.active_job.queue_name_prefix = "mirco_" + Rails.env.to_s
  end
end
