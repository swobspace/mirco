# frozen_string_literal: true

module Servers
  class AlertsController < AlertsController
    before_action :set_alertable

    private

    def set_alertable
      @alertable = Server.find(params[:server_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_alertable, @alert])
    end

    def add_breadcrumb_index
      # skip
    end

  end
end
