class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :lid, null: false
      t.string :name, default: ''

      t.timestamps
    end
    add_index :locations, :lid
  end
end
