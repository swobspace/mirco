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
      channel_statistic.touch(:last_condition_change)
    else
      channel_statistic.update(condition: 'ok')
      channel_statistic.touch(:last_condition_change)
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
    # create only alerts for destinations
    return true if channel_statistic.status_type == 'CHANNEL'

    if channel_statistic.condition == 'ok'
      alert = channel_statistic.alerts.create(
                type: 'recovery', 
                message: "#{channel_statistic} has recovered"
              )
    else
      alert = channel_statistic.alerts.create(
                type: 'alert', 
                message: "#{channel_statistic.queued} messages," +
                         " but no messages sent in the last 30 minutes"
              )
    end
    send_alert(alert)
    alert.persisted?
  end

  def send_alert(alert)
    # send mail is disabled unless mail_to is explicit configured
    return unless Mirco.mail_to.any?

    # avoid duplicate alerts, one for the destination and one for the channel itself
    return if alert.alertable&.status_type == 'CHANNEL'

    NotificationMailer.with(alert: alert).alert.deliver_later
  end
end
