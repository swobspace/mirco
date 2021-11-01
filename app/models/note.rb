class Note < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel, optional: true
  belongs_to :user, class_name: 'Wobauth::User'

  # -- configuration
  TYPES = ['acknowledge', 'mail', 'note']
  self.inheritance_column = nil
  has_rich_text :message

  # -- validations and callbacks
  validates :server_id, :user_id, presence: true
  validates :type, inclusion: TYPES, allow_blank: false

  def to_s
    "#{created_at.localtime.to_formatted_s(:db)} #{server}::#{channel} #{type.upcase} - #{message.to_plain_text}"
  end

end
