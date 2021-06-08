class Channels::FetchStatisticsJob < ApplicationJob
  queue_as :default

  def perform(options = {})
    options.symbolize_keys!
    server = options.fetch(:server) { Server.all.to_a }

    if server.kind_of? Array
      server.each do |srv|
        # create one job for each server
        Channels::FetchStatisticsJob.perform_later(server: srv)
      end
    else
      Rails.logger.debug("DEBUG:: fetch statistics job from #{server.name}")
      result = Statistics::FetchAll.new(server: server).call
      if result.success?
        Rails.logger.debug("DEBUG:: fetching statistics from server #{server.name} successful")
      else
        msg = "WARN:: fetch channel statistics failed, server: #{@server}\n"
        msg += result.error_messages.join("\n")
        Rails.logger.warn(msg)
      end
      Turbo::StreamsChannel.broadcast_replace_to :queued_messages,
        target: :queued_messages,
        partial: 'home/index',
        locals: {queued_messages: ChannelStatistic.where('channel_statistics.queued > 0').order('queued desc') }
    end

  end
end
