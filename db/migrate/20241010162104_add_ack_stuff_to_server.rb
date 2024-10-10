class AddAckStuffToServer < ActiveRecord::Migration[7.1]
  def change
    add_column :servers, :acknowledge_id, :bigint
    add_column :servers, :condition_message, :string, default: ''
  end
end
