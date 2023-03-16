class EscalationTime < ApplicationRecord
  # -- associations
  belongs_to :escalation_level, optional: true

  # -- configuration
  # -- validations and callbacks
  before_validation :check_weekdays
  validates :weekdays, presence: true

  before_save :set_default_time_frame

  # EscalationTime.current
  # using PostgreSQL functions:
  # CURRENT_TIME: time of day
  # CURRENT_DATE: date
  # ISODOW: 1 = monday, ..., 7 = sunday
  scope :current, ->{ 
          where('start_time <= CURRENT_TIME and end_time >= CURRENT_TIME')
          .where('weekdays @> Array[(SELECT EXTRACT(ISODOW FROM CURRENT_DATE))]::integer[]')
        }

  def to_s
    weekdays.map{|d| I18n.t('date.abbr_day_names')[d%7]}.join(",") + " " +
    start_time.to_fs(:time) + "-" + end_time.to_fs(:time)
  end

  private

  def set_default_time_frame
    self[:start_time] = '00:00:00' if start_time.nil?
    self[:end_time]   = '23:59:59' if end_time.nil?
  end

  def check_weekdays
    self[:weekdays] = weekdays & Array(1..7)
  end
end
