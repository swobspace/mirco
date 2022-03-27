# frozen_string_literal: true

module Servers
  class ChannelsController < ChannelsController
    before_action :set_server

    private

    def set_server
      @server = Server.find(params[:server_id])
    end

    def location
      server_path(@server, anchor: 'channels-tab')
    end
  end
end
