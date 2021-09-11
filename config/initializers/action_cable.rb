if Rails.env.production? and Mirco.action_cable_allowed_request_origins
  Rails.application.config.action_cable.allowed_request_origins = Mirco.action_cable_allowed_request_origins
end
