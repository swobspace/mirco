class ChannelStatisticProcessor
  attr_reader :channel_statistic

  def initialize(channel_statistic)
    @channel_statistic = channel_statistic
    @old_condition = channel_statistic.condition
  end

  def process
    unless channel_statistic.save
      errs = channel_statistic&.errors&.full_messages&.join("; ")
      Rails.logger.warn("WARN:: channel_statistic  #{channel_statistic.id} could not be saved: #{errs}")
      return false
    end
    unless channel_statistic.touch
      errs = channel_statistic&.errors&.full_messages&.join("; ")
      Rails.logger.warn("WARN:: channel_statistic #{channel_statistic.id} could not be touched: #{errs}")
      return false
    end
    unless channel_counter.save
      errs = channel_counter&.errors&.full_messages&.join("; ")
      Rails.logger.warn("WARN:: channel_counter #{channel_counter.id} could not be saved: #{errs}")
      return false
    end
    unless update_condition
      Rails.logger.warn("WARN:: condition of channel_statistic #{channel_statistic.id} could not be updated")
      return false
    end
    return true
  end

  private
  attr_reader :old_condition

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

  def update_condition
    channel_statistic.update_condition
    channel_statistic.save!
    return true unless condition_changed?
    channel_statistic.touch(:last_condition_change) &&
      ChannelStatisticAlertProcessor.new(channel_statistic).process
    # process some notification
  end

  def condition_changed?
    Rails.logger.debug("DEBUG:: condition changed: #{old_condition} -> #{channel_statistic.condition}")
    old_condition != channel_statistic.condition
  end

  def current_condition
    channel_statistic.escalation_status.state
  end

end
