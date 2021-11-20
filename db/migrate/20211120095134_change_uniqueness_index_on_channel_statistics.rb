class ChangeUniquenessIndexOnChannelStatistics < ActiveRecord::Migration[6.1]
  def change
    remove_index :channel_statistics, :channel_id
    add_index :channel_statistics, [ :channel_id, :meta_data_id ], unique: true
  end
end
