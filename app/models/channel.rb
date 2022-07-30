# frozen_string_literal: true

# rubocop:todo Rails/UniqueValidationWithoutIndex, Rails/InverseOf
class Channel < ApplicationRecord
  # -- associations
  belongs_to :server
  has_one :channel_statistic, -> { where(meta_data_id: nil) }
  has_many :channel_statistics, dependent: :destroy
  has_many :channel_counters, dependent: :delete_all
  has_many :alerts, dependent: :destroy
  has_many :notes, dependent: :destroy

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
  before_save :check_enabled

  delegate :location, :ipaddress, to: :server

  scope :active, -> { where(enabled: true) }

  def to_s
    name.to_s
  end

  def fullname
    "#{server.to_s} > #{name}"
  end

  def source_connector
    @source_connector ||= Mirco::Connector.new(sourceConnector, channel: self) if sourceConnector.present?
  end

  def destination_connectors
    @destination_connectors ||= if destinationConnectors.present?
                                  dconns = destinationConnectors['connector']
                                  if dconns.is_a? Array
                                    dconns
                                  else
                                    [dconns]
                                  end
                                else
                                  []
                                end.map { |c| Mirco::Connector.new(c, channel: self) }
  end

  def puml
    {
      alias: "ch_#{id}",
      text: name.to_s
    }
  end

  def disabled?
    !enabled
  end

  private
  def check_enabled
    if exportData.present? && exportData['metadata'].present? && exportData['metadata']['enabled'] == 'false'
      self[:enabled] = false
    else
      self[:enabled] = true
    end
  end
  
end
# rubocop:enable Rails/UniqueValidationWithoutIndex, Rails/InverseOf
