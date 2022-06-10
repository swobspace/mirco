require 'uri'

class InterfaceConnector < ApplicationRecord
  # -- associations
  belongs_to :software_interface
  has_many :source_connections, 
           class_name: "SoftwareConnection",
           foreign_key: :source_connector_id,
           dependent: :restrict_with_error
  has_many :destination_connections, 
           class_name: "SoftwareConnection",
           foreign_key: :destination_connector_id,
           dependent: :restrict_with_error

  # -- configuration
  TYPES = %w[ TxConnector RxConnector ]

  self.inheritance_column = nil
  has_rich_text :description

  # -- validations and callbacks
  before_save :check_url_host
  validates :name, :software_interface_id, :url, :type, presence: true
  validates_inclusion_of :type, in: TYPES

  delegate :port, :host, :scheme, to: :uri
  delegate :location, :hostname, :ipaddress, to: :software_interface

  def to_s
    "#{name} (#{url})"
  end

  def to_label
    # "#{url} - #{name} - #{sw_name}, #{location.lid}"
    "#{name} (#{url}) > #{sw_name}/#{if_name} > #{location.lid}"
  end

  def if_name
    "#{software_interface&.name}"
  end

  def sw_name
    "#{software_interface&.software&.name}"
  end

  def uri
    URI(url)
  end

  def direction
    case type
    when 'TxConnector'
      'out'
    when 'RxConnector'
      'in'
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end

  def software_connections
    case type
    when 'TxConnector'
      source_connections
    when 'RxConnector'
      destination_connections
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end

  private

  def check_url_host
    if software_interface.present? and software_interface.ipaddress.present?
      uri = URI(url)
      uri.host = software_interface.ipaddress.to_s
      self[:url] = uri.to_s
    end
  end
  
end
