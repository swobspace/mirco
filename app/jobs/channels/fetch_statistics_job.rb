# frozen_string_literal: true

module Channels
  # fetch statistics data from all channels at once
  class FetchStatisticsJob < ApplicationJob
    queue_as :default
    # self.cron_expression = Mirco.cron_expression

    # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
    def perform(options = {})
      options.symbolize_keys!
      server = options.fetch(:server) { Server.active.to_a }

      if server.is_a? Array
        server.each do |srv|
          # create one job for each server
          Channels::FetchStatisticsJob.perform_later(server: srv)
        end
      else
        Rails.logger.debug("DEBUG:: fetch statistics job from #{server.name}")
        result = Statistics::FetchAll.new(server: server, create_channel: true).call
        if result.success?
          Rails.logger.debug("DEBUG:: #{server.name}: fetching statistics successful")
        else
          msg = "WARN:: #{server.name}: fetch channel statistics failed\n" +
                result.error_messages.join("\n")
          Rails.logger.warn(msg)
        end
        Turbo::StreamsChannel.broadcast_refresh_later_to(:home)
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def max_attempts
      0
    end
  end
end
