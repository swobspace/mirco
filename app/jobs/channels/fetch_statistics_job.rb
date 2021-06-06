class Channels::FetchStatisticsJob < ApplicationJob
  queue_as :default

  def perform(options = {})
    options.symbolize_keys!
    servers = options.fetch(:server) { Server.all }
    servers = Array(servers)
    Rails.logger.debug("DEBUG:: fetch statistics job from #{servers.map{|s| s.name}}")

    servers.each do |srv|
      result = Statistics::FetchAll.new(server: srv).call
      if result.success?
        Rails.logger.debug("DEBUG:: fetching statistics from server #{srv.name} successful")
      else
        msg = "WARN:: fetch channel statistics failed, server: #{@server}\n"
        msg += result.error_messages.join("\n")
        Rails.logger.warn(msg)
      end
    end
    
  end
end
