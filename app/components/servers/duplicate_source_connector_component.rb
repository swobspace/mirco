# frozen_string_literal: true

class Servers::DuplicateSourceConnectorComponent < ViewComponent::Base
  def initialize(server:)
    @server = server
  end

  def render?
    duplicates.any?
  end

  def duplicates
    urls = server.channels.active
                 .map{|c| c.source_connector}
                 .map{|s| s&.url}.compact.sort
    urls.uniq.select{ |url| urls.count(url) > 1 }
  end

  private
  attr_reader :server
end
