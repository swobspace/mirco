class AddChannelIdUniquenessToChannelStatistic < ActiveRecord::Migration[6.1]
  def change
    remove_index :channel_statistics, :channel_id
    add_index :channel_statistics, :channel_id, unique: true
  end
end
