class CreateEscalationLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :escalation_levels do |t|
      t.references :escalatable, polymorphic: true, null: false
      t.string :attrib, null: false
      t.integer :min_critical
      t.integer :min_warning
      t.integer :max_warning
      t.integer :max_critical

      t.timestamps
    end
    add_index :escalation_levels, :attrib
  end
end
