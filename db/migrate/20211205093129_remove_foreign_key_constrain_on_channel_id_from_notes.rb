class RemoveForeignKeyConstrainOnChannelIdFromNotes < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:notes, :channel_id, true)
    if foreign_key_exists?(:notes, :channels)
      remove_foreign_key :notes, :channels
    end
  end
end
