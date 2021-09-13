class ChannelDecorator < Draper::Decorator
  delegate_all

  # sc = source connector
  def sc_transport_name
    if sc.present?
      sc['transportName']
    end
  end

  def sc
    object.sourceConnector
  end

end
