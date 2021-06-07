# Scheduling after application start
Sidekiq.set_schedule('channels_fetch_statistics', 
                     {
                       'interval' => [ "#{Mirco.check_interval}m" ],
                       'class' => 'Channels::FetchStatisticsJob'
                     }
                    )
SidekiqScheduler::Scheduler.instance.reload_schedule!
