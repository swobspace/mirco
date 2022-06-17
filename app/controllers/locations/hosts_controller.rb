# frozen_string_literal: true

module Locations
  class HostsController < HostsController
    before_action :set_location

    private

    def set_location
      @location = Location.find(params[:location_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_location, @host])
    end

    def rlocation
      location_path(@location)
    end
  end
end
