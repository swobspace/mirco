class RemoveHostnameFromSoftwareInterface < ActiveRecord::Migration[6.1]
  def change
    remove_column :software_interfaces, :hostname, type: :string, default: ""
    remove_column :software_interfaces, :ipaddress, type: :inet
  end
end
