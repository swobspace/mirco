# frozen_string_literal: true

module ServerConcerns
  extend ActiveSupport::Concern

  included do
    scope :ok, -> { where(condition: EscalationLevel::OK) }
    scope :warning, -> { where(condition: EscalationLevel::WARNING) }
    scope :critical, -> { where(condition: EscalationLevel::CRITICAL) }
    scope :failed, -> { where("servers.condition > ?", EscalationLevel::OK) }
  end

  def active_channels
    if last_channel_update.nil?
      channels
    else
      channels.where('channels.updated_at >= ?', 1.minute.before(last_channel_update))
    end
  end

  def obsolete_channels
    if last_channel_update.nil?
      channels.none
    else
      channels.where('channels.updated_at <= ?', 1.hour.before(last_channel_update))
    end
  end

end
