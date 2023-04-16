module Servers
  class FetchConfigurationJob < ApplicationJob
    queue_as :default

    def perform(options = {})
      options.symbolize_keys!
      server = options.fetch(:server) { Server.where(manual_update: false).to_a }

      if server.is_a? Array
        server.each do |srv|
          # create one job for each server
          Servers::FetchConfigurationJob.perform_later(server: srv)
        end
      else
        Rails.logger.debug("DEBUG:: server backup #{server.name}")
        backup = BackupServer.new(server)
        if backup.create(comment: "Scheduled configuration backup")
          Rails.logger.debug("DEBUG:: #{server.name}: backup server configuration successful")
        else
          msg = "WARN:: #{server.name}: backup server configuration failed\n" +
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
