class TimeToStringInEscalationTimes < ActiveRecord::Migration[7.0]
  def up
    change_column :escalation_times, :start_time, :string, 
                  limit: 8, default: '00:00:00'
    change_column :escalation_times, :end_time, :string,
                  limit: 8, default: '23:59:59'
  end

  def down
    execute <<-SQL
      ALTER TABLE escalation_times
        ALTER COLUMN start_time TYPE time USING start_time::time without time zone;
      ALTER TABLE escalation_times
        ALTER COLUMN end_time TYPE time USING end_time::time without time zone;
    SQL
    # change_column :escalation_times, :start_time, 'time without time zone'
    # change_column :escalation_times, :end_time, 'time without time zone'
  end
end
