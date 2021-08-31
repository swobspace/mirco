class ChannelCounter < ApplicationRecord
  # -- associations
  belongs_to :channel
  belongs_to :server
  # -- configuration
  # -- validations and callbacks

  # -- scopes
  scope :time_bucket, -> (time_dimension, value: 'max(queued)') {
    select(<<~SQL)
          time_bucket('#{time_dimension}', created_at) as time,
          #{value} as value
      SQL
      .group('time').order('time')
  }

  scope :per_minute, -> { time_bucket('1 minute') }
  scope :per_5min, -> { time_bucket('5 minute') }
  scope :per_15min, -> { time_bucket('15 minute') }
  scope :per_hour, -> { time_bucket('1 hour') }
  scope :per_day, -> { time_bucket('1 day') }

  scope :last_month, -> { where('created_at > ?', 1.month.ago) }
  scope :last_week, -> { where('created_at > ?', 1.week.ago) }
  scope :last_hour, -> { where('created_at > ?', 1.hour.ago) }
  scope :yesterday, -> { where('DATE(created_at) = ?', 1.day.ago.to_date) }
  scope :today, -> { where('DATE(created_at) = ?', Date.today) }
  
end
