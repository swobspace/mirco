# frozen_string_literal: true

class ServerConfiguration < ApplicationRecord
  # -- associations
  belongs_to :server

  # -- configuration
  has_one_attached :xmlfile

  # -- validations and callbacks

  def to_s
    "server-config-#{server.to_s}-#{created_at.localtime.to_formatted_s(:db).tr(' ', '_')}"
  end
end
