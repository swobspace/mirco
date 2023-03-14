class CreateNotificationGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_groups do |t|
      t.string :name

      t.timestamps
    end
    add_index :notification_groups, :name
  end
end
