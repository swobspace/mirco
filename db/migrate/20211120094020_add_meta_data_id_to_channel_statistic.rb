# frozen_string_literal: true

class AddMetaDataIdToChannelStatistic < ActiveRecord::Migration[6.1]
  def change
    add_column :channel_statistics, :meta_data_id, :integer, default: nil
  end
end
