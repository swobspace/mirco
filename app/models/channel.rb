class Channel < ApplicationRecord
  # -- associations
  belongs_to :server
  has_many :channel_statistics, dependent: :destroy
  has_many :channel_counters, dependent: :destroy

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
  validates :uid, presence: true, uniqueness: { scope: :server_id }

  def to_s
    "#{name}"
  end

end
