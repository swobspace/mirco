class Software < ApplicationRecord
  # -- associations
  belongs_to :location
  belongs_to :software_group
  has_many :software_interfaces, dependent: :restrict_with_error
  has_many :interface_connectors, through: :software_interfaces

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :location_id, presence: true

  def to_s
    "#{name} (#{location&.lid})"
  end

end
