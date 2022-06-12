class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :software_group, null: false, foreign_key: true
      t.string :name, default: ""
      t.inet :ipaddress

      t.timestamps
    end
  end
end
