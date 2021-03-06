# frozen_string_literal: true

# autostart CronJob scheduling
# see https://github.com/codez/delayed_cron_job/README.md for more information
#
namespace :db do
  desc 'Schedule all cron jobs'
  task schedule_jobs: :environment do
    # Need to load all jobs definitions in order to find subclasses
    glob = Rails.root.join('app', 'jobs', '**', '*_job.rb')
    Dir.glob(glob).sort.each { |file| require file }
    CronJob.subclasses.each(&:schedule)
  end
end

# invoke schedule_jobs automatically after every migration and schema load.
%w[db:migrate db:schema:load].each do |task|
  Rake::Task[task].enhance do
    Rake::Task['db:schedule_jobs'].invoke
  end
end
