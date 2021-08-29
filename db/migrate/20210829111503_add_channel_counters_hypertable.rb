class AddChannelCountersHypertable < ActiveRecord::Migration[6.1]
  def change
    execute "SELECT create_hypertable('channel_counters', 'created_at');"
  end
end
