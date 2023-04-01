class NotificationGroup < ApplicationRecord
  # -- associations
  has_and_belongs_to_many :users, inverse_of: :notification_groups, 
                                  class_name: 'Wobauth::User',
                                  association_foreign_key: :wobauth_user_id

  has_many :escalation_levels, dependent: :restrict_with_error

  # -- configuration
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{name}"
  end

end
