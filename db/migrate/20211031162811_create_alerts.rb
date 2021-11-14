class CreateAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :alerts do |t|
      t.belongs_to :server, null: false, foreign_key: true
      t.belongs_to :channel, null: false, foreign_key: true
      t.string :type
      t.text :message

      t.timestamps
    end
    add_index :alerts, :type
  end
end
