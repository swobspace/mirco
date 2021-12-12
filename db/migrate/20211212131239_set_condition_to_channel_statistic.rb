class SetConditionToChannelStatistic < ActiveRecord::Migration[6.1]
  def change
    ChannelStatistic.where(condition: '').each do |cs|
      cs.update(condition: 'ok')
    end
  end
end
