class Server < ApplicationRecord
  # -- associations
  # -- configuration
  encrypts :api_password

  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :uid, uniqueness: { case_sensitive: false, allow_blank: true }

  def to_s
    "#{name}"
  end


end
