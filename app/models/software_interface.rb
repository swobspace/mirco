class SoftwareInterface < ApplicationRecord
  # -- associations
  belongs_to :software
  belongs_to :host
  has_many :interface_connectors, dependent: :restrict_with_error

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :software_id, presence: true

  delegate :location, :hostname, :ipaddress, to: :host, allow_nil: :true
  delegate :lid, to: :location, allow_nil: true

  def to_s
    "#{name} (#{hostname})"
  end

end
