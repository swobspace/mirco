class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.belongs_to :server, null: false, foreign_key: true
      t.string :uid, null: false
      t.jsonb :properties

      t.timestamps
    end
    add_index :channels, :uid
  end
end
