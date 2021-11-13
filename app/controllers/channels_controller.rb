class ChannelsController < ApplicationController
  before_action :set_server
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channels
  def index
    @channels = Channel.all
    respond_with(@channels)
  end

  # GET /channels/1
  def show
    respond_with(@channel) do |format|
      format.puml {
        render format: :puml, layout: false
      }
      format.svg {
        diagram = Mirco::ChannelDiagram.new(@channel)
        send_file diagram.image(:svg), :filename => "#{@channel.server.name}-#{@channel.name}.svg",
                        :disposition => 'inline',
                        :type => 'image/svg+xml'
      }

    end
  end

  def fetch_all
    result = Channels::FetchAll.new(server: @server).call
    unless result.success?
      @server.errors.add(:base, :invalid)
      flash[:error] = "WARN:: fetch channels failed, server: #{@server}"
      flash[:error] += "<br/>"
      flash[:error] += result.error_messages.join("<br/>")
      Rails.logger.warn(flash[:error])
    end
    respond_with(@server, render: 'servers/show')
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
    respond_with(@channel, location: @channel.server)
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id])
  end

  # Only allow a trusted parameter "white list" through.
  def channel_params
    params.require(:channel).permit(:server_id, :uid, :properties)
  end

    # --- file stuff

    def filebase
      File.join( Rails.root, 'tmp', "server-#{@channel.id}" )
    end

    def pumlfile
      "#{filebase}.puml"
    end

    def svgfile
      "#{filebase}.svg"
    end
    
end
