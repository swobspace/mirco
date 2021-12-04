# frozen_string_literal: true

module Mirco
  class ServerDiagram < Diagram
    def initialize(server, _options = {})
      @server = server
    end

    def render_puml
      ApplicationController.render(
        assigns: { server: server },
        template: 'servers/show',
        formats: [:puml],
        layout: false
      )
    end

    def basename
      "server_#{server.id}"
    end

    def type
      'server'
    end

    private

    attr_reader :server
  end
end
