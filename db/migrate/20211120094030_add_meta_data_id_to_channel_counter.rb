# frozen_string_literal: true

class AddMetaDataIdToChannelCounter < ActiveRecord::Migration[6.1]
  def change
    add_column :channel_counters, :meta_data_id, :integer, default: nil
  end
end
