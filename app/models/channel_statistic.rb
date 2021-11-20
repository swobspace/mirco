class ChannelStatistic < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel
  # -- configuration
  # -- validations and callbacks
  validates :server_id, :server_uid, presence: true
  validates :meta_data_id, uniqueness: { scope: [:server_id, :channel_id] }
  validates :channel_uid, presence: true, uniqueness: { scope: [:server_id, :meta_data_id] }
  validates :channel_id, presence: true, uniqueness: { scope: [:server_id, :meta_data_id] }
end
