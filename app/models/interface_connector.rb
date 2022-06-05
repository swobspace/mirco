require 'uri'

class InterfaceConnector < ApplicationRecord
  # -- associations
  belongs_to :software_interface

  # -- configuration
  TYPES = %w[ TxConnector RxConnector ]

  self.inheritance_column = nil
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :software_interface_id, :url, :type, presence: true
  validates_inclusion_of :type, in: TYPES

  delegate :port, :host, :scheme, to: :uri
  delegate :location, :hostname, :ipaddress, to: :software_interface

  def to_s
    "#{name} (#{url})"
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


end
