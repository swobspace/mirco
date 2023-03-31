class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :channel_statistics_group, :escalation_level do |t|
      t.index [:channel_statistics_group_id, :escalation_level_id], name: 'idx_statisticsgroup_escalation'
      t.index [:escalation_level_id, :channel_statistics_group_id], name: 'idx_escalation_statisticsgroup'
    end
  end
end
