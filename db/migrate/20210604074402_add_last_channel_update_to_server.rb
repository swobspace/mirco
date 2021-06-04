class AddLastChannelUpdateToServer < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :last_channel_update, :timestamp
  end
end
