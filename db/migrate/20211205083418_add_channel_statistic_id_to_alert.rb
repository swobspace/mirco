class AddChannelStatisticIdToAlert < ActiveRecord::Migration[6.1]
  def change
    add_reference :alerts, :channel_statistic, null: true, foreign_key: false
  end
end
