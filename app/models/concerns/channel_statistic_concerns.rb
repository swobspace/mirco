# frozen_string_literal: true

module ChannelStatisticConcerns
  extend ActiveSupport::Concern

  included do
    def self.escalated
      results = []
      EscalationLevel.where(escalatable_type: 'ChannelStatistic')
                     .where("escalatable_id > 0").each do |el|
        state = EscalationLevel.check_for_escalation(el.escalatable, el.attrib)
        if state > 0
          results << el.escalatable 
        end
      end
      results
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

  def escalation_status(attribs = [])
    attribs = Array(attribs)
    unless attribs.any?
      attribs = escalatable_attributes
    end
    state = EscalationLevel::NOTHING
    attribs.each do |attr|
      lstate = EscalationLevel.check_for_escalation(self, attr)
      if lstate > state
        state = lstate
      end
    end
    state
  end

end
