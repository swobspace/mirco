class AddVendorToSoftware < ActiveRecord::Migration[6.1]
  def change
    add_column :software, :vendor, :string, default: ''
  end
end
