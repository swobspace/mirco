class AddCurrentNoteIdToChannelStatistic < ActiveRecord::Migration[7.0]
  def change
    add_reference :channel_statistics, :current_note, null: true, foreign_key: false
  end
end
