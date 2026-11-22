module Servers
  class FetchPropertiesJob < ApplicationJob
    queue_as :default

    def perform(options = {})
      options.symbolize_keys!
      server = options.fetch(:server) { Server.active.to_a }

      if server.is_a? Array
        server.each do |srv|
          # create one job for each server
          Servers::FetchPropertiesJob.perform_later(server: srv)
        end
      else
        Rails.logger.debug("DEBUG:: server params #{server.name}")
        result = System::FetchParams.new(server: server).call
        if result.success?
          server.update(properties: result.params)
        else
          msg = "WARN:: #{server.name}: update properties failed\n" +
                result.error_messages.join("\n")
          Rails.logger.warn(msg)
        end
      end
    end

    def max_attempts
      0
    end
  end
end
