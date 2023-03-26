class CreateEscalationTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :escalation_times do |t|
      t.belongs_to :escalation_level, null: false, foreign_key: true
      t.string :start_time, limit: 5, default: '00:00'
      t.string :end_time, limit: 5, default: '23:59'
      t.integer :weekdays, array: true

      t.timestamps
    end
  end
end
