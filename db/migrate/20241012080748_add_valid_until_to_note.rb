class AddValidUntilToNote < ActiveRecord::Migration[7.1]
  def change
    add_column :notes, :valid_until, :datetime
  end
end
