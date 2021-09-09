class AddLastCheckToServer < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :last_check, :timestamp
    add_column :servers, :last_check_ok, :timestamp
  end
end
