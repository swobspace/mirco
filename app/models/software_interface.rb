class SoftwareInterface < ApplicationRecord
  # -- associations
  belongs_to :software
  has_many :interface_connectors, dependent: :restrict_with_error

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :software_id, presence: true

  delegate :location, to: :software

  def to_s
    "#{name} (#{hostname})"
  end

end
