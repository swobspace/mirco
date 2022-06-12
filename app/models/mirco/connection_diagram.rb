# frozen_string_literal: true

module Mirco
  class ConnectionDiagram < Diagram
    def initialize(connection, _options = {})
      @connection = connection
      if !oldest_filedate.nil? && oldest_filedate < connection.updated_at
        delete
      end
    end

    def render_puml
      ApplicationController.render(
        assigns: { software_connection: connection },
        template: 'software_connections/show',
        formats: [:puml],
        layout: false
      )
    end

    def basename
      "connection_#{connection.id}"
    end

    def type
      'connection'
    end

    private

    attr_reader :connection
  end
end
