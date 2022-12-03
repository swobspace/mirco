class EscalationLevel < ApplicationRecord
  # -- associations
  # optional: true is neccessary for default values using escalatable_id: 0
  belongs_to :escalatable, polymorphic: true, optional: true

  # -- configuration
  OK       = 0.freeze
  WARNING  = 1.freeze
  CRITICAL = 2.freeze
  UNKNOWN  = 3.freeze

  # -- validations and callbacks
  validates :escalatable_id, presence: true, 
                             uniqueness: { scope: %i[escalatable_type attrib] }
  validates :escalatable_type, presence: true, 
                               uniqueness: { scope: %i[escalatable_id attrib] }
  validates :attrib, presence: true, 
                     uniqueness: { scope: %i[escalatable_id escalatable_type] }

  def to_s
    "#{escalatable} / #{attrib}"
  end

  # EscalationLevel.check_for_escalation(escalatable, attribute)
  # return Nagios style values:
  #   0: OK
  #   1: WARNING
  #   2: CRITICAL
  #   3: UNKNOWN
  #
  def self.check_for_escalation(escalatable, attrib)
    return UNKNOWN unless escalatable.respond_to?(attrib)
    value = fetch_value(escalatable, attrib)
    level = fetch_escalation_level(escalatable, attrib)
    if level.min_critical.present? && (value < level.min_critical)
      return CRITICAL
    elsif level.min_warning.present? && (value < level.min_warning)
      return WARNING
    elsif level.max_critical.present? && (value >= level.max_critical)
      return CRITICAL
    elsif level.max_warning.present? && (value >= level.max_warning)
      return WARNING
    else
      return OK
    end
  end

private

  def self.fetch_value(escalatable, attrib)
    value = escalatable.send(attrib)
    if value.kind_of?(Time)
      value = ((value - Time.current) / 1.minute).round
    end
    value
  end

  # 1. check if matching escalation level exists in database
  # 2. else check if matching default record exists (having escalatable_id: 0)
  # 3. otherwise create an instance of NullEscalationLevel

  def self.fetch_escalation_level(escalatable, attrib)
    escalatable.escalation_levels.where(attrib: attrib).first ||
    EscalationLevel.where(escalatable_type: escalatable.class.name.to_s, 
                          escalatable_id: 0, attrib: attrib).first ||
    NullEscalationLevel.new(escalatable, attrib)
  end
end
