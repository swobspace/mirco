if Rails.env.production? 
  Rails.application.configure do
    if Mirco.smtp_settings.nil?
      config.action_mailer.delivery_method = :file
    else
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = Mirco.smtp_settings
    end
  end
end
