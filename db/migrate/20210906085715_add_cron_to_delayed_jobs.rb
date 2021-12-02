# frozen_string_literal: true

class AddCronToDelayedJobs < ActiveRecord::Migration[6.1]
  def self.up
    add_column :delayed_jobs, :cron, :string
  end

  def self.down
    remove_column :delayed_jobs, :cron
  end
end
