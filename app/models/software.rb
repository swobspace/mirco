class Software < ApplicationRecord
  # -- associations
  belongs_to :location
  has_many :software_interfaces, dependent: :restrict_with_error

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :location_id, presence: true

  def to_s
    "#{name}"
  end

end
