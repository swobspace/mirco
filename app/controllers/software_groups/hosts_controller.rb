# frozen_string_literal: true

module SoftwareGroups
  class HostsController < HostsController
    before_action :set_hostable

    private

    def set_hostable
      @hostable = SoftwareGroup.find(params[:software_group_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_hostable, @host])
    end

    def rlocation
      # Rails.logger.debug("DEBUG:: #{@hostable.inspect}")
      software_group_path(@hostable)
    end
  end
end
