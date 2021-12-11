# frozen_string_literal: true

module ChannelStatistics
  class NotesController < NotesController
    before_action :set_notable

    private

    def set_notable
      @notable = ChannelStatistic.find(params[:channel_statistic_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_notable, @note])
    end
  end
end
