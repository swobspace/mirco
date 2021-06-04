class Channel < ApplicationRecord
  # -- associations
  belongs_to :server

  # -- configuration
  store_accessor :properties, :name
  store_accessor :properties, :description
  store_accessor :properties, :revision
  store_accessor :properties, :version
  store_accessor :properties, :exportData
  store_accessor :properties, :sourceConnector
  store_accessor :properties, :destinationConnectors
  store_accessor :properties, :deployScript
  store_accessor :properties, :undeployScript
  store_accessor :properties, :preprocessingScript
  store_accessor :properties, :postprocessingScript

  # -- validations and callbacks
  validates :uid, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{name}"
  end

end
