class ChannelStatisticAlertProcessor
  attr_reader :channel_statistic

  def initialize(channel_statistic)
    @channel_statistic = channel_statistic
  end

  def process
    # create only alerts for connectors
    return true if channel_statistic.status_type == 'CHANNEL'

    last_alert_state = channel_statistic.alerts.order('created_at desc').first&.type

    if (channel_statistic.condition == EscalationLevel::OK) &&
       (last_alert_state == 'alert' || last_alert_state.nil?)
      alert = channel_statistic.alerts.create(
                type: 'ok',
                message: "OK: #{channel_statistic} has recovered"
              )
      channel_statistic.update(current_note_id: nil)
    elsif (channel_statistic.condition > EscalationLevel::WARNING) &&
          (last_alert_state == 'ok' || last_alert_state.nil?)
      alert = channel_statistic.alerts.create(
                type: 'alert',
                message: channel_statistic.escalation_status.message
              )
    end
    send_alert(alert)
    alert.nil? || alert.persisted?
  end

  # needs more grips :-)
  # should be extracted to a configurable NotificationProcessor 
  def send_alert(alert)
    return if alert.nil?
    # send mail is disabled unless mail_to is explicit configured
    return unless Mirco.mail_to.any?

    # avoid duplicate alerts, one for the destination and one for the channel itself
    return if alert.alertable&.status_type == 'CHANNEL'
    return unless alert.type == 'alert'
    if alert.alertable.escalation_status('last_message_sent_at').state <= EscalationLevel::OK   
      return
    end

    NotificationMailer.with(alert: alert).alert.deliver_later
  end

end
