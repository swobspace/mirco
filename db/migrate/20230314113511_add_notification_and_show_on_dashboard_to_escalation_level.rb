class AddNotificationAndShowOnDashboardToEscalationLevel < ActiveRecord::Migration[7.0]
  def change
    add_reference :escalation_levels, :notification_group, null: true
    add_column :escalation_levels, :show_on_dashboard, :boolean, default: false
    add_index :escalation_levels, :show_on_dashboard
  end
end
