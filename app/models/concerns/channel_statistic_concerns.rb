# frozen_string_literal: true

module ChannelStatisticConcerns
  extend ActiveSupport::Concern

  included do
    # filter enabled channels
    scope :active, -> do
      joins(channel: :server).where("channels.enabled = true")
                             .where("servers.manual_update = ?", false)
                             .where("servers.disabled = ?", false)
    end

    # filter older statistics
    scope :current, -> (interval = 1.day) do
      where('channel_statistics.updated_at > ?', interval.before(Time.current))
    end

    scope :escalated, -> do
      where('channel_statistics.meta_data_id IS NOT NULL')
      .where("channel_statistics.condition > ?", EscalationLevel::OK)
    end

    scope :queued, -> do
      where('channel_statistics.meta_data_id IS NOT NULL')
      .where("channel_statistics.queued > 0")
    end

    scope :condition, -> (state) do
      where('channel_statistics.condition = ?', state)
    end
    scope :ok, -> { condition(Mirco::States::OK) }
    scope :warning, -> { condition(Mirco::States::WARNING) }
    scope :critical, -> { condition(Mirco::States::CRITICAL) }
    scope :unknown, -> { condition(Mirco::States::UNKNOWN) }
    scope :nothing, -> { condition(Mirco::States::NOTHING) }
    scope :failed, -> do
      where("connectors.condition > ?", Mirco::States::OK)
      .where(manual_update: false)
    end


  end

  def sent_last_30min
    channel_counters.last_30min
                    .increase
                    .map(&:delta).map(&:to_i).reduce(0, :+)
  end

  def received_last_30min
    channel_counters.last_30min
                    .increase(value: 'received')
                    .map(&:delta).map(&:to_i).reduce(0, :+)
  end

  def error_last_30min
    channel_counters.last_30min
                    .increase(value: 'error')
                    .map(&:delta).map(&:to_i).reduce(0, :+)
  end

  def filtered_last_30min
    channel_counters.last_30min
                    .increase(value: 'filtered')
                    .map(&:delta).map(&:to_i).reduce(0, :+)
  end

end
