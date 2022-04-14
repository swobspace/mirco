if Mirco.devise_modules.include?(:remote_user_authenticatable)
  require 'devise_remote_user'

  DeviseRemoteUser.configure do |config|
    config.env_key =  ->(env) { "#{env['REMOTE_USER']}".downcase }
    config.auto_create = false
    config.auto_update = false
    config.attribute_map = {email: 'mail'}
  end

end
