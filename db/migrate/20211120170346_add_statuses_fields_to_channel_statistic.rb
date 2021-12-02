class AddStatusesFieldsToChannelStatistic < ActiveRecord::Migration[6.1]
  def change
    add_column :channel_statistics, :name, :string, default: ''
    add_column :channel_statistics, :state, :string, default: ''
    add_column :channel_statistics, :status_type, :string, default: ''
  end
end
