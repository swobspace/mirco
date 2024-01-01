class AddConditionToServer < ActiveRecord::Migration[7.1]
  def change
    add_column :servers, :condition, :integer, default: 0
    add_index :servers, :condition
  end
end
