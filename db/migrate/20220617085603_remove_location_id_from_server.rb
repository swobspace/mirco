class RemoveLocationIdFromServer < ActiveRecord::Migration[6.1]
  def change
    remove_reference :servers, :location, foreign_key: true
  end
end
