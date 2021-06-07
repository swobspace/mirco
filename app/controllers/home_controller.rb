class HomeController < ApplicationController
  def index
    @channel_statistics = ChannelStatistic.where('channel_statistics.queued > 0').order('queued desc')
  end
end
