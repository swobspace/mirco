class SoftwareGroup < ApplicationRecord
  # -- associations
  has_many :hosts, dependent: :restrict_with_error
  has_many :software, dependent: :restrict_with_error

  # -- configuration

  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{name}"
  end

end
