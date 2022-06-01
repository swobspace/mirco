class CreateSoftwareConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :software_connections do |t|
      t.belongs_to :source_connector, null: false, foreign_key: false
      t.string :source_url, default: ""
      t.belongs_to :destination_connector, null: false, foreign_key: false
      t.string :destination_url, default: ""
      t.boolean :ignore, default: false
      t.string :ignore_reason, default: ""
      t.timestamps
    end

    add_index :software_connections, [:source_url, :destination_url], unique: true
  end
end
