class Channels::AlertsController < AlertsController
  before_action :set_channel

private

  def set_channel
    @channel = Channel.find(params[:channel_id])
    @server  = @channel.server
  end

  def location
    server_channel_path(@server, @channel)
  end
end

