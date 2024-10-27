class AddConditionToChannel < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :condition, :integer, default: 0
    add_index :channels, :condition
    add_column :channels, :condition_message, :string, default: ''
    add_column :channels, :acknowledge_id, :bigint
  end
end
