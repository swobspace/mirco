# frozen_string_literal: true

module Servers
  class NotesController < NotesController
    before_action :set_notable

    private

    def set_notable
      @notable = Server.find(params[:server_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_notable, @note])
    end

    def add_breadcrumb_index
      # skip
    end
  end
end
