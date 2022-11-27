# frozen_string_literal: true

module Channels
  # fetch statistics data from all channels at once
  class FetchJob < ApplicationJob
    queue_as :default
    # self.cron_expression = '0 1 * * 6'

    # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
    def perform(options = {})
      options.symbolize_keys!
      server = options.fetch(:server) { Server.where(manual_update: false).to_a }

      if server.is_a? Array
        server.each do |srv|
          # create one job for each server
          Channels::FetchJob.perform_later(server: srv)
        end
      else
        Rails.logger.debug("DEBUG:: fetch channel job from #{server.name}")
        result = Channels::FetchAll.new(server: server).call
        if result.success?
          Rails.logger.debug("DEBUG:: #{server.name}: fetching channels successful")
        else
          msg = "WARN:: #{server.name}: fetch channels failed\n" +
                result.error_messages.join("\n")
          Rails.logger.warn(msg)
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def max_attempts
      0
    end
  end
end
