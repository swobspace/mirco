# frozen_string_literal: true

module ServerConcerns
  extend ActiveSupport::Concern

  included do
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
