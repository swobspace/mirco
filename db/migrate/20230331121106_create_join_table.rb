class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :channel_statistics, :channel_statistic_groups do |t|
      t.index [:channel_statistic_group_id, :channel_statistic_id], name: 'idx_statisticsgroup_statistic'
      t.index [:channel_statistic_id, :channel_statistic_group_id], name: 'idx_statistic_statisticsgroup'
    end
  end
end
