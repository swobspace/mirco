class ChannelStatisticProcessor
  attr_reader :channel_statistic

  def initialize(channel_statistic)
    @channel_statistic = channel_statistic
  end

  def process
    channel_statistic.save && channel_statistic.touch && channel_counter.save && update_condition
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

  def update_condition
    return true unless condition_changed?
    toggle_condition && create_alert_entry
    # process some notification
  end

  # if condition.blank? always assume a change (first try)
  # else process alert same as acknowledge
  def condition_changed?
    # ok -> alert || alert, acknowledged -> ok
    (current_condition == 'ok' and channel_statistic.condition != 'ok') ||
    (current_condition != 'ok' and channel_statistic.condition == 'ok') ||
    channel_statistic.condition.blank?
  end

  def toggle_condition
    if ( channel_statistic.condition == 'ok' )
      channel_statistic.update(condition: 'alert')
    else
      channel_statistic.update(condition: 'ok')
    end
  end

  def current_condition
    if channel_statistic.sent_last_30min.zero? && channel_statistic.queued > Mirco.queued_warning_level
      'alert' 
    else
      'ok'
    end
  end

  def create_alert_entry
    if channel_statistic.condition == 'ok'
      alert = channel_statistic.alerts.create(type: 'recovery', message: "#{channel_statistic} has recovered")
      send_alert(alert)
    else
      alert = channel_statistic.alerts.create(type: 'alert', message: "#{channel_statistic.queued} messages, but no messages sent in the last 30 minutes")
      send_alert(alert)
    end
    alert.persisted?
  end

  def send_alert(alert)
    return unless Mirco.mail_to.any?
    NotificationMailer.with(alert: alert).alert.deliver_later
  end
end
