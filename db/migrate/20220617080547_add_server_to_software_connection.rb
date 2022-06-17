class AddServerToSoftwareConnection < ActiveRecord::Migration[6.1]
  def change
    add_reference :software_connections, :server
  end
end
