# frozen_string_literal: true

# rubocop:todo Rails/UniqueValidationWithoutIndex
class ChannelStatistic < ApplicationRecord
  include ChannelStatisticConcerns
  # -- associations
  belongs_to :server
  belongs_to :channel
  has_many :channel_counters, dependent: :delete_all
  has_many :alerts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :escalation_levels, as: :escalatable

  # has_many :channel_counters, ->(cs) {
  #   unscope(:where).where(
  #     "server_id = :server_id and channel_id = :channel_id and meta_data_id = :meta_id",
  #      server_id: cs.server_id,
  #      channel_id: cs.channel_id,
  #      meta_id: cs.meta_data_id
  #   )
  # }

  # -- configuration
  CONDITIONS = %w[alert acknowledged ok].freeze
  alias_attribute :to_s, :name

  # -- validations and callbacks
  validates :server_id, :server_uid, presence: true
  validates :meta_data_id, uniqueness: { scope: %i[server_id channel_id] }, allow_nil: true
  validates :channel_uid, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
  validates :channel_id, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
  validates :condition, inclusion: CONDITIONS, allow_blank: true
  before_update :update_last_at

  # --
  scope :active, -> { joins(:channel).where("channels.enabled = true") }

  # --
  def fullname
    "#{server.to_s} > #{channel.to_s} > #{name}"
  end

  def escalatable_attributes
    %w[ queued updated_at last_message_received_at 
        last_message_sent_at last_message_error_at ]
  end

private
  def update_last_at
    if will_save_change_to_attribute?(:received) && received > 0
      touch(:last_message_received_at) 
    end
    if will_save_change_to_attribute?(:sent) && sent > 0
      touch(:last_message_sent_at) 
    end
    if will_save_change_to_attribute?(:error) && error > 0
      touch(:last_message_error_at) 
    end
  end

end
# rubocop:enable Rails/UniqueValidationWithoutIndex

