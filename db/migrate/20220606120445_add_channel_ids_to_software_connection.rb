class AddChannelIdsToSoftwareConnection < ActiveRecord::Migration[6.1]
  def change
    add_column :software_connections, :channel_ids, :integer, array: true
  end
end
