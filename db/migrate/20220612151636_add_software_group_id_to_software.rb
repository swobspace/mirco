class AddSoftwareGroupIdToSoftware < ActiveRecord::Migration[6.1]
  def change
    add_reference :software, :software_group, foreign_key: true
  end
end
