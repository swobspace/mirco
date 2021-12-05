class RemoveForeignKeyConstrainOnChannelIdFromAlerts < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:alerts, :channel_id, true)
    if foreign_key_exists?(:alerts, :channels)
      remove_foreign_key :alerts, :channels
    end
  end
end
