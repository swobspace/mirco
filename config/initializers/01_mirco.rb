module Mirco
  CONFIGURATION_CONTROLLER = [
    "servers"
  ]
  CONFIGFILE = File.join(Rails.root, 'config', 'mirco.yml')
  if File.readable? CONFIGFILE
    config = YAML.load_file(CONFIGFILE)
  end
  CONFIG = config || Hash.new

  def self.devise_modules
    if CONFIG['devise_modules'].present?
      CONFIG['devise_modules']
    else
      [ :remote_user_authenticatable,
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :trackable
      ]
    end
  end

  def self.ldap_options
    if CONFIG['ldap_options'].present?
      ldapopts = CONFIG['ldap_options']
      if ldapopts.kind_of? Hash
        ldapopts = [ldapopts]
      end
      ldapopts.each do |opts|
        opts.symbolize_keys!
        opts.each do |k,v|
          opts[k] = opts[k].symbolize_keys if opts[k].kind_of? Hash
        end
      end
    else
      nil
    end
  end

  def self.mail_from
    if CONFIG['mail_from'].present?
      CONFIG['mail_from']
    else
      'root'
    end
  end

  def self.use_ssl
    if CONFIG['use_ssl'].present?
      CONFIG['use_ssl']
    else
      false
    end
  end

  def self.remote_user
    if CONFIG['remote_user'].present?
      CONFIG['remote_user']
    else
      "REMOTE_USER"
    end
  end

  def self.action_cable_allowed_request_origins
    if CONFIG['action_cable_allowed_request_origins'].present?
      Array(CONFIG['action_cable_allowed_request_origins'])
    else
      [ 'http://localhost', 'https://localhost' ]
    end
  end

  def self.host
    if CONFIG['host'].present?
      CONFIG['host']
    else
      "localhost"
    end
  end

  def self.script_name
    if CONFIG['script_name'].present?
      CONFIG['script_name']
    else
      "/"
    end
  end

  def self.mail_to
    if CONFIG['mail_to'].present?
      Array(CONFIG['mail_to'])
    else
      []
    end
  end

  ActionMailer::Base.default_url_options = {
   host: self.host,
   script_name: self.script_name
  }
  Rails.application.routes.default_url_options[:host] = self.host
  Rails.application.routes.default_url_options[:script_name] = self.script_name

end
