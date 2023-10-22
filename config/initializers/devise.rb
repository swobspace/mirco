Devise.setup do |config|
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
