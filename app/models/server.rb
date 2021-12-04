# frozen_string_literal: true

# rubocop:todo Rails/UniqueValidationWithoutIndex
class Server < ApplicationRecord
  include ServerConcerns
  # -- associations
  has_many :alerts, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :server_notes, -> { where(channel_id: nil) }, class_name: 'Note', dependent: :destroy, inverse_of: :server
  has_many :channels, dependent: :restrict_with_error
  has_many :channel_statistics, dependent: :restrict_with_error
  has_many :channel_counters, dependent: :destroy
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

  delegate :to_s, to: :name
end
# rubocop:enable Rails/UniqueValidationWithoutIndex
