# frozen_string_literal: true

module Mirco
  CONFIGURATION_CONTROLLER = [
    'servers'
  ].freeze
  CONFIGFILE = File.join(Rails.root, 'config', 'mirco.yml')
  config = YAML.load_file(CONFIGFILE) if File.readable? CONFIGFILE
  CONFIG = config || {}

  def self.devise_modules
    CONFIG['devise_modules'].presence || %i[remote_user_authenticatable
                                            database_authenticatable
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

  def self.mail_from
    fetch_config('mail_from', 'root')
  end

  def self.use_ssl
    fetch_config('use_ssl', false)
  end

  def self.remote_user
    fetch_config('remote_user', 'REMOTE_USER')
  end

  def self.cron_expression
    fetch_config('cron_expression', '*/5 * * * *')
  end

  # warning if last check is older than warning_period minutes
  def self.warning_period
    fetch_config('warning_period', 10)
  end

  # warning if queued_messages > queued_warning_level
  def self.queued_warning_level
    fetch_config('queued_warning_level', 10)
  end

  # critical if queued_messages > queued_critical_level
  def self.queued_critical_level
    fetch_config('queued_critical_level', 50)
  end

  def self.action_cable_allowed_request_origins
    if CONFIG['action_cable_allowed_request_origins'].present?
      Array(CONFIG['action_cable_allowed_request_origins'])
    else
      ['http://localhost', 'https://localhost']
    end
  end

  def self.host
    CONFIG['host'].presence || 'localhost'
  end

  def self.port
    CONFIG['port'].presence || nil
  end

  def self.script_name
    if CONFIG['script_name'].present?
      CONFIG['scriptname']
    else
      '/'
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
    port: self.port,
    script_name: self.script_name
  }
  Rails.application.routes.default_url_options[:host] = self.host
  Rails.application.routes.default_url_options[:port] = self.port
  Rails.application.routes.default_url_options[:script_name] = self.script_name

  def self.fetch_config(attribute, default_value)
    CONFIG[attribute.to_s].presence || default_value
  end
end
