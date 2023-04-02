# frozen_string_literal: true

# rubocop:todo Rails/UniqueValidationWithoutIndex
class ChannelStatistic < ApplicationRecord
  include ChannelStatisticConcerns
  include EscalationStatusConcerns
  # -- associations
  belongs_to :server
  belongs_to :channel
  has_many :channel_counters, dependent: :delete_all
  has_many :alerts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :escalation_levels, as: :escalatable, dependent: :destroy
  has_and_belongs_to_many :channel_statistic_groups, inverse_of: :channel_statistics
  has_many :group_escalation_levels, through: :channel_statistic_groups, source: :escalation_levels

  # has_many :channel_counters, ->(cs) {
  #   unscope(:where).where(
  #     "server_id = :server_id and channel_id = :channel_id and meta_data_id = :meta_id",
  #      server_id: cs.server_id,
  #      channel_id: cs.channel_id,
  #      meta_id: cs.meta_data_id
  #   )
  # }

  # -- configuration
  alias_attribute :to_s, :name

  # -- validations and callbacks
  validates :server_id, :server_uid, presence: true
  validates :meta_data_id, uniqueness: { scope: %i[server_id channel_id] }, allow_nil: true
  validates :channel_uid, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
  validates :channel_id, presence: true, uniqueness: { scope: %i[server_id meta_data_id] }
  validates :condition, numericality: { in: EscalationLevel::STATES }, allow_nil: true
  before_update :update_last_at

  # --
  def fullname
    "#{server.to_s} > #{channel.to_s} > #{name}"
  end

  def self.escalatable_attributes
    %w[ queued updated_at last_message_received_at
        last_message_sent_at last_message_error_at ]
  end

  def escalatable_attributes
    ChannelStatistic.escalatable_attributes
  end

  def all_escalation_levels
    @all ||= (escalation_levels + group_escalation_levels)
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

