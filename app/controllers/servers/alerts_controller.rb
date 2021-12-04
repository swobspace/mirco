# frozen_string_literal: true

module Servers
  class AlertsController < AlertsController
    before_action :set_server

    private

    def set_server
      @server = Server.find(params[:server_id])
    end

    def location
      server_path(@server)
    end
  end
end
