# frozen_string_literal: true

module Servers
  class ChannelStatisticsController < ChannelStatisticsController
    before_action :set_server

    def fetch_all
      result = Statistics::FetchAll.new(server: @server, create_channel: true).call
      unless result.success?
        @server.errors.add(:base, :invalid)
        flash[:error] = "WARN:: fetch channel statistics failed, server: #{@server}" \
                        '<br/>' + result.error_messages.join('<br/>').truncate(500)
        Rails.logger.warn(flash[:error])
      end
      respond_with(@server, location: location, render: 'servers/show')
    end

    private

    def set_server
      @server = Server.find(params[:server_id])
    end

    def location
      server_path(@server)
    end

    def add_breadcrumb_index
      # skip
    end
  end
end
