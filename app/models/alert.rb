# frozen_string_literal: true

class Alert < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel, optional: true
  belongs_to :channel_statistic, optional: true

  # -- configuration
  TYPES = %w[alert ok].freeze
  self.inheritance_column = nil

  # -- validations and callbacks
  before_validation :set_server_and_channel_id
  validates :server_id, :message, presence: true
  validates :type, inclusion: TYPES, allow_blank: false
  validate :alert_message_present

  def to_s
    "#{server}::#{channel} #{type.upcase} - #{message}"
  end

  def alertable
    if channel_statistic.present?
      channel_statistic
    elsif channel.present?
      channel
    else
      server
    end
  end

  private

  def set_server_and_channel_id
    self[:channel_id] = channel_statistic.channel_id if channel_id.blank? && channel_statistic_id.present?
    self[:server_id] = channel.server_id if server_id.blank? && channel_id.present?
    true
  end

  def alert_message_present
    errors.add(:message, "can't be empty") if message.blank?
  end
end
