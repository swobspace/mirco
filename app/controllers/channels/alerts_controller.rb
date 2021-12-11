# frozen_string_literal: true

module Channels
  class AlertsController < AlertsController
    before_action :set_alertable

    private

    def set_alertable
      @alertable = Channel.find(params[:channel_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_alertable, @alert])
    end

  end
end
