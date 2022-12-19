class Host < ApplicationRecord
  # -- associations
  belongs_to :location
  belongs_to :software_group
  has_many :servers, dependent: :restrict_with_error
  has_many :software_interfaces, dependent: :restrict_with_error

  alias_attribute :hostname, :name

  # -- configuration
  has_rich_text :description

  # -- validations and callbacks
  validates :location_id, :software_group_id, presence: true
  validates :name, presence: true,
            format: { with: /\A[a-z][a-z0-9._-]{2,}\z/i }


  def to_s
    "#{name} (#{ipaddress})"
  end

  def pumlify
    name.downcase.gsub(/-/, '_')
  end

end
