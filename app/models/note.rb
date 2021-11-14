class Note < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel, optional: true
  belongs_to :user, class_name: 'Wobauth::User'

  # -- configuration
  TYPES = ['acknowledge', 'mail', 'note']
  self.inheritance_column = nil

  # for checks only
  attr_accessor :message
  # action text
  has_rich_text :message

  # -- validations and callbacks
  before_validation :set_server_id
  validates :server_id, :user_id, presence: true
  validates :type, inclusion: TYPES, allow_blank: false
  validate :note_message_present

  def to_s
    "#{created_at.localtime.to_formatted_s(:db)} #{server}::#{channel} #{type.upcase} - #{message.to_plain_text}"
  end

private

  def set_server_id
    if server_id.blank? and channel_id.present?
      self[:server_id] = channel.server_id
    end
    true
  end

  def note_message_present
    if self.message.blank?
      self.errors.add(:message, "can't be empty")
    end
  end
end
