class CreateChannelStatisticGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_statistic_groups do |t|
      t.string :name, default: ''

      t.timestamps
    end
  end
end
