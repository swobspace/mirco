if Rails.env.production? 
  if Mirco.smtp_settings.nil?
    ActionMailer::Base.delivery_method = :file
  else
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = Mirco.smtp_settings
  end
end
