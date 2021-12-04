# frozen_string_literal: true

class AddChannelStatisticIdToChannelCounter < ActiveRecord::Migration[6.1]
  def change
    add_reference :channel_counters, :channel_statistic, null: true
  end
end
