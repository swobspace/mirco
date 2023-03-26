class CreateJoinTableNotificationGroupWobauthUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :notification_groups, :wobauth_users do |t|
      t.index [:notification_group_id, :wobauth_user_id], name: 'idx_notificationgroup_user'
      t.index [:wobauth_user_id, :notification_group_id], name: 'idx_user_notificationgroup'
    end
  end
end
