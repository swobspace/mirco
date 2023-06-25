# frozen_string_literal: true

class ChannelCounter < ApplicationRecord
  # -- associations
  belongs_to :channel
  belongs_to :server
  belongs_to :channel_statistic
  # -- configuration
  # -- validations and callbacks

  # -- scopes
  scope :time_bucket, lambda { |time_dimension, value: 'max(queued)'|
    select(<<~SQL)
      #{tm_bucket}('#{time_dimension}', created_at) as time,
      #{value} as value
    SQL
      .group('time').order('time')
  }

  # increase(value: 'error')
  scope :increase, lambda { |value: 'sent'|
    select(<<~SQL)
      created_at as time,
      (
        CASE
          WHEN #{value} >= lag(#{value}) OVER (ORDER BY created_at)
            THEN #{value} - lag(#{value}) OVER  (ORDER BY created_at)
          WHEN lag(#{value}) OVER (ORDER BY created_at) IS NULL THEN NULL
          ELSE #{value}
        END
      ) as delta
    SQL
      .order('time')
  }

  scope :per_minute, -> { time_bucket('1 minute') }
  scope :per_5min, -> { time_bucket('5 minute') }
  scope :per_15min, -> { time_bucket('15 minute') }
  scope :per_hour, -> { time_bucket('1 hour') }
  scope :per_6hour, -> { time_bucket('6 hour') }
  scope :per_day, -> { time_bucket('1 day') }

  scope :time_period, lambda { |start, ende|
    where('created_at > ? and created_at <= ?', start, ende)
  }
  scope :last_month, -> { time_period(1.month.ago, Time.current) }
  scope :last_week,  -> { time_period(1.week.ago,  Time.current) }
  scope :last_30min, -> { time_period(30.minutes.ago, Time.current) }
  scope :last_hour,  -> { time_period(1.hour.ago, Time.current) }
  scope :last_8h,    -> { time_period(8.hours.ago,  Time.current) }
  scope :last_24h,   -> { time_period(24.hours.ago, Time.current) }

  scope :yesterday, -> { where('DATE(created_at) = ?', 1.day.ago.to_date) }
  scope :today, -> { where('DATE(created_at) = ?', Date.current) }

  def self.tm_bucket
    if Mirco::timescale_license == 'apache'
      "time_bucket"
    else
      "time_bucket_gapfill"
    end
  end
end
