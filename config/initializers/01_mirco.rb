# frozen_string_literal: true

module Mirco
  CONFIGFILE = File.join(Rails.root, 'config', 'mirco.yml')
  config = YAML.load_file(CONFIGFILE) if File.readable? CONFIGFILE
  CONFIG = config || {}

  CONFIGURATION_CONTROLLER = [
    'locations',
    'channel_statistic_groups',
    'escalation_levels',
    'notification_groups',
  ].freeze

  SOFTWARE_CONTROLLER = [
    'software_groups',
    'software',
    'software_interfaces',
    'interface_connectors',
    'software_connections',
  ].freeze

  SERVERS_CONTROLLER = [
    'servers',
    'alerts',
    'channels',
    'channel_statistics',
  ]

  def self.fetch_config(attribute, default_value)
    CONFIG[attribute.to_s].presence || default_value
  end


  def self.devise_modules
    CONFIG['devise_modules'].presence || %i[database_authenticatable
                                            registerable
                                            recoverable
                                            rememberable
                                            trackable]
  end

  def self.ldap_options
    if CONFIG['ldap_options'].present?
      ldapopts = CONFIG['ldap_options']
      ldapopts = [ldapopts] if ldapopts.is_a? Hash
      ldapopts.each do |opts|
        opts.symbolize_keys!
        opts.each do |k, _v|
          opts[k] = opts[k].symbolize_keys if opts[k].is_a? Hash
        end
      end
    end
  end

  def self.enable_ldap_authentication
    return false unless self.ldap_options.present?
    fetch_config('enable_ldap_authentication', false)
  end

  def self.mail_from
    fetch_config('mail_from', 'root')
  end

  def self.mail_to
    Array(fetch_config('mail_to', nil))
  end


  def self.use_ssl
    fetch_config('use_ssl', false)
  end

  def self.remote_user
    fetch_config('remote_user', 'REMOTE_USER')
  end

  def self.cron_fetch_statistics
    fetch_config('cron_fetch_statistics', '*/5 * * * *')
  end

  def self.cron_fetch_channels
    fetch_config('cron_fetch_channels', '0 1 * * 6')
  end

  def self.cron_fetch_configuration
    fetch_config('cron_fetch_configuration', '15 1 * * 6')
  end

  def self.cron_purge_timescale
    fetch_config('cron_purge_timescale', '30 1 * * 6')
  end

  def self.action_cable_allowed_request_origins
    fetch_config('action_cable_allowed_request_origins', 
                 ['http://localhost', 'https://localhost'])
  end

  def self.action_cable_url
    fetch_config('action_cable_url', nil)
  end

  def self.host
    fetch_config('host', 'localhost')
  end

  def self.port
    fetch_config('port', nil)
  end

  def self.script_name
    fetch_config('script_name', '/')
  end

  def self.smtp_settings
    fetch_config('smtp_settings', nil)
  end

  def self.timescale_license
    mylicense = "SHOW timescaledb.license;"
    @@timescale_license ||= ActiveRecord::Base.connection.exec_query(mylicense).rows.flatten.first || "apache"
  end

  ActionMailer::Base.default_url_options = {
    host: host,
    port: port,
    script_name: script_name
  }

  Rails.application.routes.default_url_options[:host] = host
  Rails.application.routes.default_url_options[:port] = port
  Rails.application.routes.default_url_options[:script_name] = script_name

end
