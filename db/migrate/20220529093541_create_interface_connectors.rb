class CreateInterfaceConnectors < ActiveRecord::Migration[6.1]
  def change
    create_table :interface_connectors do |t|
      t.belongs_to :software_interface, null: false, foreign_key: true
      t.string :type, default: ''
      t.string :url, default: ''

      t.timestamps
    end
    add_index :interface_connectors, :type
  end
end
