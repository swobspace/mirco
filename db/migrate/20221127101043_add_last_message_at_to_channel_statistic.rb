class AddLastMessageAtToChannelStatistic < ActiveRecord::Migration[7.0]
  def change
    add_column :channel_statistics, :last_message_received_at, :timestamp
    add_column :channel_statistics, :last_message_sent_at, :timestamp
    add_column :channel_statistics, :last_message_error_at, :timestamp
  end
end
