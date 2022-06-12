class Host < ApplicationRecord
  # -- associations
  belongs_to :location
  belongs_to :software_group
  has_many :servers, dependent: :restrict_with_error
  has_many :software_interfaces, dependent: :restrict_with_error

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :name, :location_id, :software_group_id, presence: true

  def to_s
    "#{name} (#{ipaddress})"
  end

end
