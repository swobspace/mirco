class Host < ApplicationRecord
  belongs_to :location
  belongs_to :software_group
  has_rich_text :description
end
