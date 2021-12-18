class AddConditionToChannelStatistic < ActiveRecord::Migration[6.1]
  def change
    add_column :channel_statistics, :condition, :string, default: ''
    add_index :channel_statistics, :condition
    add_column :channel_statistics, :last_condition_change, :timestamp
  end
end
