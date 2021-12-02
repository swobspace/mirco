# frozen_string_literal: true

# CronJob
# from https://github.com/codez/delayed_cron_job/README.md
# Default configuration in `app/jobs/application_job.rb`
#
class CronJob < ApplicationJob
  class_attribute :cron_expression

  class << self
    def schedule
      set(cron: cron_expression).perform_later unless scheduled?
    end

    def remove
      delayed_job.destroy if scheduled?
    end

    def scheduled?
      delayed_job.present?
    end

    def delayed_job
      Delayed::Job
        .where('handler LIKE ?', "%job_class: #{name}%")
        .first
    end
  end
end
