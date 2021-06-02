class Channel < ApplicationRecord
  # -- associations
  belongs_to :server

  # -- configuration
  store_accessor :properties, :channel_uid
  store_accessor :properties, :name
  store_accessor :properties, :description
  store_accessor :properties, :revision

  # -- validations and callbacks
  validates :uid, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{name}"
  end

end
