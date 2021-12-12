class ChannelStatisticProcessor
  attr_reader :channel_statistic

  def initialize(channel_statistic)
    @channel_statistic = channel_statistic
  end

  def process
    channel_statistic.save && channel_statistic.touch && channel_counter.save
  end

  private

  def channel_counter
    channel_statistic.channel_counters.build(
      server_id: channel_statistic.server_id,
      channel_id: channel_statistic.channel_id,
      meta_data_id: channel_statistic.meta_data_id,
      received: channel_statistic.received,
      sent: channel_statistic.sent,
      error: channel_statistic.error,
      filtered: channel_statistic.filtered,
      queued: channel_statistic.queued
    )
  end
end
