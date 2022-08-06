# frozen_string_literal: true

class Puml::MultipleConnectionsServerComponent < ViewComponent::Base
  def initialize(server:)
    @server = server
  end

  private
  attr_reader :server

end
