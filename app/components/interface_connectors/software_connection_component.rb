# frozen_string_literal: true

class InterfaceConnectors::SoftwareConnectionComponent < ViewComponent::Base
  def initialize(software_connection:, interface_connector:)
    @software_connection = software_connection
    @interface_connector = interface_connector
  end

  private
  attr_reader :software_connection, :interface_connector, :btn_class

  def addremove_text
    case interface_connector.type
    when 'TxConnector'
      (software_connection.source_connector.present?) ? remove : add
    when 'RxConnector'
      (software_connection.destination_connector.present?) ? remove : add
    end
  end

  def remove
    @btn_class = 'btn btn-warning'
    I18n.t('mirco.remove_connection')
  end

  def add
    @btn_class = 'btn btn-primary'
    I18n.t('mirco.add_connection')
  end

  def addremove_params
    case interface_connector.type
    when 'TxConnector'
      if software_connection.source_connector.present?
        { software_connection: { source_connector_id: nil }}
      else
        { software_connection: { source_connector_id: interface_connector.id }}
      end
    when 'RxConnector'
      if software_connection.destination_connector.present?
        { software_connection: { destination_connector_id: nil }}
      else
        { software_connection: { destination_connector_id: interface_connector.id }}
      end
    end
  end

end
