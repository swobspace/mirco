class AddDisabledToServer < ActiveRecord::Migration[7.2]
  def change
    add_column :servers, :disabled, :boolean, default: false
  end
end
