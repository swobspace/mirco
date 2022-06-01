class SoftwareConnection < ApplicationRecord
  belongs_to :source_connector
  belongs_to :destination_connector
  has_rich_text :description
end
