class SoftwareConnection < ApplicationRecord
  belongs_to :source_connector, -> { where(type: 'TxConnector') },
             class_name: "InterfaceConnector"
  belongs_to :destination_connector, -> { where(type: 'RxConnector') },
             class_name: "InterfaceConnector"
  has_rich_text :description
end
