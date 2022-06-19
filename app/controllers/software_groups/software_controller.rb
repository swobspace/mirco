# frozen_string_literal: true

module SoftwareGroups
  class SoftwareController < SoftwareController
    before_action :set_softwareable

    private

    def set_softwareable
      @softwareable = SoftwareGroup.find(params[:software_group_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_softwareable, @software])
    end

    def location
      software_group_path(@softwareable)
    end
  end
end
