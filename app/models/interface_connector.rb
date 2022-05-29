require 'uri'

class InterfaceConnector < ApplicationRecord
  # -- associations
  belongs_to :software_interface

  # -- configuration
  self.inheritance_column = nil
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :software_interface_id, :url, :type, presence: true

  def to_s
    "#{name} (#{url})"
  end

  delegate :port, :host, :scheme, to: :uri

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
