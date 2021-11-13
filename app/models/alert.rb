class Alert < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel

  # -- configuration
  TYPES = ['alert', 'recovery']
  self.inheritance_column = nil

  # -- validations and callbacks
  validates :channel_id, :server_id, :message, presence: true
  validates :type, inclusion: TYPES, allow_blank: false

  def to_s
    "#{server}::#{channel} #{type.upcase} - #{message}"
  end

end