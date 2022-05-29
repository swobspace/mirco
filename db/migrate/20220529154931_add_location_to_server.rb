class AddLocationToServer < ActiveRecord::Migration[6.1]
  def change
    add_reference :servers, :location, foreign_key: true
  end
end
