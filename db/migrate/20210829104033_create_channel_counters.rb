class CreateChannelCounters < ActiveRecord::Migration[6.1]
  def change
    create_table :channel_counters, id: false do |t|
      t.belongs_to :channel, null: false
      t.belongs_to :server, null: false
      t.integer :received
      t.integer :sent
      t.integer :error
      t.integer :filtered
      t.integer :queued

      t.timestamps
    end
  end
end
