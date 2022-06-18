# frozen_string_literal: true

module Locations
  class HostsController < HostsController
    before_action :set_hostable

    private

    def set_hostable
      @hostable = Location.find(params[:location_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_hostable, @host])
    end

    def rlocation
      location_path(@hostable)
    end
  end
end
