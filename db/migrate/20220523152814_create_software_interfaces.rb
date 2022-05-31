class CreateSoftwareInterfaces < ActiveRecord::Migration[6.1]
  def change
    create_table :software_interfaces do |t|
      t.belongs_to :software, null: false, foreign_key: true
      t.string :name, null: false
      t.string :hostname, default: ''
      t.inet :ipaddress

      t.timestamps
    end
  end
end
