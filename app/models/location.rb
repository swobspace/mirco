class Location < ApplicationRecord
  # -- associations
  has_many :software, dependent: :restrict_with_error
  has_many :hosts, dependent: :restrict_with_error
  has_many :servers, through: :hosts, dependent: :restrict_with_error
  has_many :software_interfaces, through: :hosts, dependent: :restrict_with_error
  has_many :software_connections, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :name, presence: true
  validates :lid, uniqueness: { case_sensitive: false, allow_blank: false }, presence: true

  def to_s
    "#{lid}: #{name}"
  end

end
