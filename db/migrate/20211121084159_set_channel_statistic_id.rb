class SetChannelStatisticId < ActiveRecord::Migration[6.1]
  class ChannelCounter < ApplicationRecord ; end
  class ChannelStatistic < ApplicationRecord ; end

  def up
    ChannelStatistic.find_each do |cs|
      ChannelCounter
      .where(server_id: cs.server_id, channel_id: cs.channel_id, 
             meta_data_id: cs.meta_data_id)
      .update_all(channel_statistic_id: cs.id)
    end
  end

  def down
    # nothing
  end

end
