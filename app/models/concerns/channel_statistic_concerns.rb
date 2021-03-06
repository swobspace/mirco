# frozen_string_literal: true

module ChannelStatisticConcerns
  extend ActiveSupport::Concern

  included do
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
