class ChangeConditionTypeChannelStatistic < ActiveRecord::Migration[7.0]
  def change
    rename_column :channel_statistics, :condition, :oldcondition

    add_column :channel_statistics, :condition, :integer, default: -1
    add_index :channel_statistics, :condition
  end
end
