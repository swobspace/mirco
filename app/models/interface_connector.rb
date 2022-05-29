class InterfaceConnector < ApplicationRecord
  belongs_to :software_interface
  has_rich_text :description
end
