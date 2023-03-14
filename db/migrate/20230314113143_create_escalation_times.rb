class CreateEscalationTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :escalation_times do |t|
      t.belongs_to :escalation_level, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.integer :weekdays, array: true

      t.timestamps
    end
  end
end
