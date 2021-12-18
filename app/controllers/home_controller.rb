# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @queued_messages = ChannelStatistic
                       .where('meta_data_id > 0')
                       .where('channel_statistics.queued > 0')
                       .where('channel_statistics.updated_at > ?', 1.day.before(Time.current))
                       .order('queued desc')
    @servers = Server.all
  end
end
