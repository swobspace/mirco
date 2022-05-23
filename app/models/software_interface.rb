class SoftwareInterface < ApplicationRecord
  belongs_to :software
  has_rich_text :description
end
