# frozen_string_literal: true

class Channel < ApplicationRecord
  # -- associations
  belongs_to :server
  has_one :channel_statistic, -> { where(meta_data_id: nil) }, dependent: :destroy
  has_many :channel_statistics, dependent: :destroy
  has_many :channel_counters, dependent: :destroy
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

  def to_s
    name.to_s
  end

  def source_connector
    @source_connector ||= Mirco::Connector.new(sourceConnector) if sourceConnector.present?
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
                                end.map { |c| Mirco::Connector.new(c) }
  end

  def puml
    {
      alias: "ch_#{id}",
      text: name.to_s
    }
  end
end
