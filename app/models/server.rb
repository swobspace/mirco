require 'uri'

# rubocop:todo Rails/UniqueValidationWithoutIndex
class Server < ApplicationRecord
  include ServerConcerns
  include EscalationStatusConcerns
  include NotableConcerns
  include Mirco::Condition

  # -- associations
  # belongs_to :location
  belongs_to :host, optional: true
  has_many :alerts, dependent: :destroy
  has_many :software_connections, dependent: :destroy
  has_many :all_notes, class_name: 'Note', dependent: :destroy, inverse_of: :server
  has_many :channels, dependent: :restrict_with_error
  has_many :channel_statistics, dependent: :restrict_with_error
  has_many :channel_counters, dependent: :destroy
  has_many :server_configurations, dependent: :restrict_with_error
  has_many :escalation_levels, as: :escalatable, dependent: :destroy

  # -- configuration
  has_encrypted :api_password
  store_accessor :properties, :server_uid
  store_accessor :properties, :server_jvm
  store_accessor :properties, :server_version
  store_accessor :properties, :server_settings
  store_accessor :properties, :system_info

  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uid, uniqueness: { case_sensitive: false, allow_blank: true }
  before_save :update_condition

  alias_attribute :to_s, :name
  alias_attribute :fullname, :name

  delegate :location, :hostname, :ipaddress, :up?, to: :host, allow_nil: true

  def uri
    URI(api_url)
  end

  def to_label
    "#{name} / #{host.name} (#{host.ipaddress}) / #{location.lid}"
  end

 def escalatable_attributes
    %w[ last_check last_check_ok ]
  end

  def update_condition
    if manual_update
      set_condition(Mirco::States::NOTHING,
                    I18n.t(Mirco::States::NOTHING, scope: 'mirco.condition') +
                    " Manual update enabled")
    elsif host.present? and !up?
      set_condition(Mirco::States::CRITICAL,
                    I18n.t(Mirco::States::CRITICAL, scope: 'mirco.condition') +
                    " Server unreachable, ping failed")
    else
      if escalation_status.state <= Mirco::States::OK
        set_condition(Mirco::States::OK,
                      I18n.t(Mirco::States::OK, scope: 'mirco.condition'))
      else
        set_condition(escalation_status.state,
                      escalation_status.message)
      end
    end
  end

end
# rubocop:enable Rails/UniqueValidationWithoutIndex
