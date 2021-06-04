module ServerConcerns
  extend ActiveSupport::Concern

  included do
  end

  def active_channels
    channels.where("channels.updated_at >= ?", 1.minute.before(last_channel_update))
  end
end
