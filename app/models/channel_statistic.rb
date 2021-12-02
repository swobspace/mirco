class ChannelStatistic < ApplicationRecord
  # -- associations
  belongs_to :server
  belongs_to :channel
  has_many :channel_counters, dependent: :destroy

  # has_many :channel_counters, ->(cs) {
  #   unscope(:where).where(
  #     "server_id = :server_id and channel_id = :channel_id and meta_data_id = :meta_id",
  #      server_id: cs.server_id,
  #      channel_id: cs.channel_id,
  #      meta_id: cs.meta_data_id
  #   )
  # }

  # -- configuration
  # -- validations and callbacks
  validates :server_id, :server_uid, presence: true
  validates :meta_data_id, uniqueness: { scope: %i[server_id channel_id] }, allow_nil: true
  validates :channel_uid, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
  validates :channel_id, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
end
