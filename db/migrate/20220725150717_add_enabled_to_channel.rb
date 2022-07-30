class AddEnabledToChannel < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :enabled, :boolean, default: true
  end
end
