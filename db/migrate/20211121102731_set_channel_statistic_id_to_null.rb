class SetChannelStatisticIdToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :channel_counters, :channel_statistic_id, false
  end
end
