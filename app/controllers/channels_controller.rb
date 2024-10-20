# frozen_string_literal: true

class ChannelsController < ApplicationController
  before_action :set_server
  before_action :set_channel, only: %i[show destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channels
  def index
    if @server
      if params[:obsolete].present?
        @channels = @server.obsolete_channels
      else
        @channels = @server.channels
      end
    else
      @channels = Channel.all
    end
    if params[:active]
      @channels = @channels.active
    end
    respond_with(@channels)
  end

  # GET /channels/1
  def show
    respond_with(@channel) do |format|
      format.puml do
        # add subchannels for chart
        @channels = [@channel]
        @channels += @channel.subchannels
        render format: :puml, layout: false
      end
      format.adoc do
        # render format: :adoc, layout: false
        adoc = render_to_string format: :adoc, layout: false
        send_data adoc,
                  filename: "#{@channel.name}.adoc",
                  disposition: :attachment,
                  type: 'text/asciidoc'
      end
      format.svg do
        # add subchannels for chart
        @channels = [@channel]
        @channels += @channel.subchannels
        diagram = Mirco::ChannelDiagram.new(@channel, channels: @channels)
        send_file diagram.image(:svg), filename: "#{@channel.server.name}-#{@channel.name}.svg",
                                       disposition: 'inline',
                                       type: 'image/svg+xml'
      end
    end
  end

  def fetch_all
    result = Channels::FetchAll.new(server: @server).call
    unless result.success?
      @server.errors.add(:base, :invalid)
      flash[:error] = "WARN:: fetch channels failed, server: #{@server}" \
                      '<br/>' + result.error_messages.join('<br/>').truncate(300)
      Rails.logger.warn(flash[:error])
    end
    respond_with(@server) do |format|
      if result.success?
        format.turbo_stream
      else
        format.html { render 'servers/show', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  def destroy
    respond_with(@channel, location: location) do |format|
      if @channel.destroy
        format.turbo_stream { flash.now[:notice] = "Channel successfully deleted" }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id]) if params[:server_id].present?
  end

  # Only allow a trusted parameter "white list" through.
  def channel_params
    params.require(:channel).permit(:server_id, :uid, :properties)
  end

  # --- file stuff

  def filebase
    Rails.root.join('tmp', "server-#{@channel.id}")
  end

  def pumlfile
    "#{filebase}.puml"
  end

  def svgfile
    "#{filebase}.svg"
  end
end
