class CreateChannelStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :channel_statistics do |t|
      t.belongs_to :server, null: false, foreign_key: true
      t.belongs_to :channel, null: false, foreign_key: true
      t.string :server_uid, null: false
      t.string :channel_uid, null: false
      t.integer :received, default: 0
      t.integer :sent, default: 0
      t.integer :error, default: 0
      t.integer :filtered, default: 0
      t.integer :queued, default: 0

      t.timestamps
    end
    add_index :channel_statistics, :server_uid
    add_index :channel_statistics, :channel_uid
  end
end
