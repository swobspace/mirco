class CreateSoftwareConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :software_connections do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :source_connector
      t.string :source_url, default: ""
      t.belongs_to :destination_connector
      t.string :destination_url, default: ""
      t.boolean :ignore, default: false
      t.string :ignore_reason, default: ""
      t.timestamps

      t.index [:location_id, :source_url, :destination_url], unique: true, name: 'index_loc_src_dst_url'
    end
  end
end
