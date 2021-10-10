class ChannelStatistic < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel
  # -- configuration
  # -- validations and callbacks
  validates :server_id, :server_uid, presence: true
  validates :channel_uid, presence: true, uniqueness: { scope: :server_id }
  validates :channel_id, presence: true, uniqueness: true

end
