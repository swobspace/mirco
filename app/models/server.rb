require 'uri'

# rubocop:todo Rails/UniqueValidationWithoutIndex
class Server < ApplicationRecord
  include ServerConcerns
  # -- associations
  belongs_to :location
  belongs_to :host
  has_many :alerts, dependent: :destroy
  has_many :software_connections, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :server_notes, -> { where(channel_id: nil) }, class_name: 'Note', dependent: :destroy, inverse_of: :server
  has_many :channels, dependent: :restrict_with_error
  has_many :channel_statistics, dependent: :restrict_with_error
  has_many :channel_counters, dependent: :destroy
  has_many :server_configurations, dependent: :restrict_with_error
  # -- configuration
  encrypts :api_password
  store_accessor :properties, :server_uid
  store_accessor :properties, :server_jvm
  store_accessor :properties, :server_version
  store_accessor :properties, :server_settings
  store_accessor :properties, :system_info

  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uid, uniqueness: { case_sensitive: false, allow_blank: true }

  alias_attribute :to_s, :name
  alias_attribute :fullname, :name

  delegate :ipaddress, to: :host

  def uri
    URI(api_url)
  end
end
# rubocop:enable Rails/UniqueValidationWithoutIndex
