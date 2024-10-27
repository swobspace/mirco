# frozen_string_literal: true

class Note < ApplicationRecord
  # -- associations
  belongs_to :notable, polymorphic: true
  belongs_to :server, optional: true
  belongs_to :channel, optional: true
  belongs_to :channel_statistic, optional: true
  belongs_to :user, class_name: 'Wobauth::User'

  # -- configuration
  TYPES = %w[acknowledge mail note].freeze
  self.inheritance_column = nil

  # for checks only
  attr_accessor :message

  # action text
  has_rich_text :message

  # -- validations and callbacks
  before_save :set_server_and_channel_id
  # validates :server_id, presence: true
  validates :user_id, presence: true
  validates :type, inclusion: TYPES, allow_blank: false
  validate :note_message_present

  def to_s
    "#{created_at.localtime.to_fs(:local)} #{server}::#{channel} #{type.upcase} - #{message.to_plain_text}"
  end

  scope :active, -> do
    where("notes.valid_until >= ? or notes.valid_until IS NULL", Time.current)
  end

  def is_active
    valid_until.nil? || valid_until >= Time.current
  end

  private

  def set_server_and_channel_id
    case self[:notable_type]
    when 'Server'
      self[:server_id] = notable.id
    when 'Channel'
      self[:channel_id] = notable.id
      self[:server_id] = notable.server_id
    when 'ChannelStatistic'
      self[:channel_statistic_id] = notable.id
      self[:channel_id] = notable.channel_id
      self[:server_id] = notable.server_id
    else 
      puts self.inspect
      raise RuntimeError, "unknown notable type"
    end
  end

  def note_message_present
    errors.add(:message, "can't be empty") if message.blank?
  end
end
