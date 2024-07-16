# frozen_string_literal: true

if Rails.env.production? 

  if Mirco.action_cable_allowed_request_origins
    Rails.application.config.action_cable.allowed_request_origins = Mirco.action_cable_allowed_request_origins
  end

  if Mirco.action_cable_url
    Rails.application.config.action_cable.url = Mirco.action_cable_url
  end
end
