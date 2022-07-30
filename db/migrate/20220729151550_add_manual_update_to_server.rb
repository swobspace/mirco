class AddManualUpdateToServer < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :manual_update, :boolean, default: false
  end
end
