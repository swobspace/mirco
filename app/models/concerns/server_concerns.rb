# frozen_string_literal: true

module ServerConcerns
  extend ActiveSupport::Concern

  included do
    scope :condition, -> (state) do
      where('servers.condition = ?', state)
      .where(manual_update: false)
    end

    scope :ok, -> { condition(Mirco::States::OK) }
    scope :warning, -> { condition(Mirco::States::WARNING) }
    scope :critical, -> { condition(Mirco::States::CRITICAL) }
    scope :unknown, -> { condition(Mirco::States::UNKNOWN) }
    scope :nothing, -> { condition(Mirco::States::NOTHING) }

    scope :failed, -> do
      where("servers.condition > ?", Mirco::States::OK)
      .where(manual_update: false)
    end

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
