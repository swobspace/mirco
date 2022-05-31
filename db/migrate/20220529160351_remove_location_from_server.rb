class RemoveLocationFromServer < ActiveRecord::Migration[6.1]
  def change
    remove_column :servers, :location
  end
end
