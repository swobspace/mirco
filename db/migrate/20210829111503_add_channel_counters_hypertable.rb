# frozen_string_literal: true

class AddChannelCountersHypertable < ActiveRecord::Migration[6.1]
  def change
    execute "SELECT create_hypertable('channel_counters', by_range('created_at', INTERVAL '1 day'), migrate_data => TRUE);"
  end
end
