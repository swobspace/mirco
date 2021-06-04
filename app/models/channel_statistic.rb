class ChannelStatistic < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel
  # -- configuration
  # -- validations and callbacks
  validates :server_id, :server_uid, :channel_id, :channel_uid, presence: true
end
