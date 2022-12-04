# frozen_string_literal: true

module ChannelStatisticConcerns
  extend ActiveSupport::Concern

  included do
    def self.escalated
      channel_statistics = []
      EscalationLevel.where(escalatable_type: 'ChannelStatistik')
                     .where("escalatable_id > 0") do |el|
        state = EscalationLevel.check_for_escalation(el.escalatable, el.attrib)
        channel_statistics << el.escalatable if state > 0
      end
      channel_statistics
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
