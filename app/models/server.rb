class Server < ApplicationRecord
  include ServerConcerns
  # -- associations
  has_many :channels, dependent: :restrict_with_error
  has_many :channel_statistics, dependent: :restrict_with_error
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

  def to_s
    "#{name}"
  end


end
