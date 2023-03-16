class EscalationTime < ApplicationRecord
  # -- associations
  belongs_to :escalation_level, optional: true

  # -- configuration
  # -- validations and callbacks
  before_validation :check_weekdays
  validates :weekdays, presence: true

  # EscalationTime.current
  # using PostgreSQL functions:
  # CURRENT_TIME: time of day
  # CURRENT_DATE: date
  # ISODOW: 1 = monday, ..., 7 = sunday
  scope :current, ->{ 
          where('start_time <= LOCALTIME::character varying(8) and end_time >= LOCALTIME::character varying(8)')
          .where('weekdays @> Array[(SELECT EXTRACT(ISODOW FROM CURRENT_DATE))]::integer[]')
        }

  def to_s
    "#{start_time}-#{end_time}" + " " +
    weekdays.map{|d| I18n.t('date.abbr_day_names')[d%7]}.join(",")
  end

  private

  def check_weekdays
    self[:weekdays] = weekdays & Array(1..7)
  end
end
