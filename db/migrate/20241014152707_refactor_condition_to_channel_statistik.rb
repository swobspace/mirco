class RefactorConditionToChannelStatistik < ActiveRecord::Migration[7.1]
  def change
    add_column :channel_statistics, :condition_message, :string, default: ''
    rename_column :channel_statistics, :current_note_id, :old_current_note_id
    add_column :channel_statistics, :acknowledge_id, :bigint
  end
end
