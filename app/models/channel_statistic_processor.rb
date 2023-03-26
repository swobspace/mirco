class ChannelStatisticProcessor
  attr_reader :channel_statistic

  def initialize(channel_statistic)
    @channel_statistic = channel_statistic
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
    channel_statistic.update(condition: current_condition) && create_alert_entry
    # process some notification
  end

  def condition_changed?
    current_condition != channel_statistic.condition
  end

  def current_condition
    channel_statistic.escalation_status.state
  end

  def create_alert_entry
    # create only alerts for destinations
    return true if channel_statistic.status_type == 'CHANNEL'

    if channel_statistic.condition == EscalationLevel::OK
      alert = channel_statistic.alerts.create(
                type: 'recovery',
                message: "OK: #{channel_statistic} has recovered"
              )
    elsif channel_statistic.condition > EscalationLevel::OK
      if channel_statistic.escalation_status('last_message_sent_at').state > EscalationLevel::OK
      alert = channel_statistic.alerts.create(
                type: 'alert',
                message: I18n.t(channel_statistic.condition, scope: 'mirco.condition') + 
                         ": #{channel_statistic.queued} messages, but not sending"
              )
      end
    end
    send_alert(alert)
    alert.nil? || alert.persisted?
  end

  def send_alert(alert)
    return if alert.nil?
    # send mail is disabled unless mail_to is explicit configured
    return unless Mirco.mail_to.any?

    # avoid duplicate alerts, one for the destination and one for the channel itself
    return if alert.alertable&.status_type == 'CHANNEL'

    NotificationMailer.with(alert: alert).alert.deliver_later
  end
end
