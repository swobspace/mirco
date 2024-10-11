class AddNotableToNote < ActiveRecord::Migration[7.1]
  def change
    add_reference :notes, :notable, polymorphic: true, null: true
  end
end
