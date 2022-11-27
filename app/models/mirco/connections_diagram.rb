# frozen_string_literal: true

module Mirco
  class ConnectionsDiagram < Diagram
    def initialize(connections, _options = {})
      @connections = Array(connections)
      if @connections.empty?
        raise RuntimeError, "ERROR:: ConnectionsDiagram.new: no connections present!"
      end
      if !oldest_filedate.nil? && oldest_filedate < updated_at(connections)
        delete
      elsif Rails.env.development?
        delete
      end
    end

    def render_puml
      ApplicationController.render(
        assigns: { software_connections: connections },
        template: 'software_connections/index',
        formats: [:puml],
        layout: false
      )
    end

    def basename
      "connections_" + Digest::SHA2.hexdigest(connections.map(&:id).sort.join("-"))
    end

    def type
      'connections'
    end

    private

    attr_reader :connections

    def updated_at(connections)
      # fetch the newest updated_at timestamp
      connections.map(&:updated_at).sort.last
    end
  end
end
