class AddStateToChannel < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :state, :string, default: ""
  end
end
