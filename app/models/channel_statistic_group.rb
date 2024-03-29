class ChannelStatisticGroup < ApplicationRecord
  # -- associations
  has_and_belongs_to_many :channel_statistics, inverse_of: :channel_statistic_groups
  has_many :escalation_levels, as: :escalatable, dependent: :destroy

  # -- configuration
  # -- validations and callbacks
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    "#{name}"
  end

  def escalatable_attributes
    ChannelStatistic.escalatable_attributes
  end

end
