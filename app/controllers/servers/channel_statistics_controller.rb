class Servers::ChannelStatisticsController < ChannelStatisticsController
  before_action :set_server

  def fetch_all
    result = Statistics::FetchAll.new(server: @server, create_channel: true).call
    unless result.success?
      @server.errors.add(:base, :invalid)
    end
    respond_with(@server, action: :show)
  end

private

  def set_server
    @server = Server.find(params[:server_id])
  end
end

