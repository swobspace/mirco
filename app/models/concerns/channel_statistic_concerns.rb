# frozen_string_literal: true

module ChannelStatisticConcerns
  extend ActiveSupport::Concern

  included do
    # filter enabled channels
    scope :active, -> do
      joins(:channel).where("channels.enabled = true")
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
