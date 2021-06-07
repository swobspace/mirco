# Scheduling after application start
Sidekiq.set_schedule('channels_fetch_statistics', 
                     {
                       'every' => [ "#{Mirco.check_interval}m", first_in: '0s' ],
                       'class' => 'Channels::FetchStatisticsJob'
                     }
                    )
# SidekiqScheduler::Scheduler.instance.reload_schedule!
