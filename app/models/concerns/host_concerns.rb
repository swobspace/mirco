# frozen_string_literal: true

module HostConcerns
  extend ActiveSupport::Concern

  included do
  end

  def up?
    check = Net::Ping::External.new(ipaddress.to_s)
    check.ping?
  end
end
