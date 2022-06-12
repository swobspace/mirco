class CreateSoftwareGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :software_groups do |t|
      t.string :name, null: false
      t.string :description, default: ""

      t.timestamps
    end
    add_index :software_groups, :name, unique: true
  end
end
