class Location < ApplicationRecord
  # -- associations
  has_many :software, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :name, presence: true
  validates :lid, uniqueness: { case_sensitive: false, allow_blank: false }, presence: true

  def to_s
    "#{lid}: #{name}"
  end

end
