class AddDefaultNotificationGroupToEscalationLevel < ActiveRecord::Migration[7.0]
  def up
    ng = NotificationGroup.find_or_create_by!(name: 'Default')
    EscalationLevel
      .where(notification_group_id: nil)
      .update_all(notification_group_id: ng.id)
  end

  def down
  end
end
