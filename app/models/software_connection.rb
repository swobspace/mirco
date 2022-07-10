class SoftwareConnection < ApplicationRecord
  include SoftwareConnectionConcerns
  # -- associations
  belongs_to :location
  belongs_to :server
  belongs_to :source_connector, -> { where(type: 'TxConnector') },
             class_name: "InterfaceConnector", optional: true
  belongs_to :destination_connector, -> { where(type: 'RxConnector') },
             class_name: "InterfaceConnector", optional: true

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :source_url, :destination_url, :location_id, presence: true
  validates :source_url, uniqueness: { scope: [:location_id, :destination_url] }

  def to_s
    "#{location&.lid}: #{source_connector} \u27A0 #{destination_connector}"
  end

  def channel_ids
    (self[:channel_ids].present?) ? self[:channel_ids] : []
  end

end
