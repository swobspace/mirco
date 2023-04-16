class EscalationLevel < ApplicationRecord
  Result = ImmutableStruct.new(:state, :escalation_level)
  # -- associations
  # optional: true is neccessary for default values using escalatable_id: 0
  belongs_to :escalatable, polymorphic: true, optional: true
  belongs_to :notification_group, optional: true
  has_many :escalation_times, dependent: :destroy

  # -- configuration
  NOTHING  = -1.freeze
  OK       = 0.freeze
  WARNING  = 1.freeze
  CRITICAL = 2.freeze
  UNKNOWN  = 3.freeze

  STATES = NOTHING..UNKNOWN

  accepts_nested_attributes_for :escalation_times,
    allow_destroy: true,
    reject_if: proc { |att| att['weekdays'].compact.blank? }

  # -- validations and callbacks
  validates :escalatable_id, presence: true,
                             uniqueness: { scope: %i[escalatable_type attrib] }
  validates :escalatable_type, presence: true,
                               uniqueness: { scope: %i[escalatable_id attrib] }
  validates :attrib, presence: true,
                     uniqueness: { scope: %i[escalatable_id escalatable_type] }

  def to_s
    if escalatable_id > 0
      "#{escalatable} / #{attrib}"
    else
      "#{escalatable_type} (default) / #{attrib}"
    end
  end

  # EscalationLevel.check_for_escalation(escalatable, attribute)
  # return Nagios style values:
  #  -1: NOTHING means no escalation_level nor default present
  #   0: OK
  #   1: WARNING
  #   2: CRITICAL
  #   3: UNKNOWN
  #
  def self.check_for_escalation(escalatable, attrib)
    # attrib.valid?
    unless escalatable.respond_to?(attrib)
      return Result.new(state: UNKNOWN, escalation_level: nil)
    end

    # value.nil?
    value = fetch_value(escalatable, attrib)
    if value.nil?
      return Result.new(state: NOTHING, escalation_level: nil)
    end

    # last sent_at only relevant if queued > 0
    if attrib == 'last_message_sent_at' && fetch_attrib(escalatable, 'queued') == 0
      return Result.new(state: NOTHING, escalation_level: nil)
    end

    # last error_at only relevant if error > 0
    if attrib == 'last_message_error_at' && fetch_attrib(escalatable, 'error') == 0
      return Result.new(state: NOTHING, escalation_level: nil)
    end

    # last received_at only relevant if received > 0
    if attrib == 'last_message_received_at' && fetch_attrib(escalatable, 'received') == 0
      return Result.new(state: NOTHING, escalation_level: nil)
    end

    # levels.empty?
    levels = fetch_escalation_levels(escalatable, attrib)
    if levels.empty?
      return Result.new(state: NOTHING, escalation_level: nil)
    end

    # loop over escalation_levels
     
    state = NOTHING
    el    = nil

    levels.each do |level| 
      # escalation_times.any?
      if level.escalation_times.any? && level.escalation_times.current.empty?
        next
      end
      if level.min_critical.present? && (value < level.min_critical)
        if state < CRITICAL
          state = CRITICAL; el = level
        end
      elsif level.min_warning.present? && (value < level.min_warning)
        if state < WARNING
          state = WARNING; el = level
        end
      elsif level.max_critical.present? && (value >= level.max_critical)
        if state < CRITICAL
          state = CRITICAL; el = level
        end
      elsif level.max_warning.present? && (value >= level.max_warning)
        if state < WARNING
          state = WARNING; el = level
        end
      else
        if state < OK
          state = OK; el = level
        end
      end
    end
    return Result.new(state: state, escalation_level: el)
  end

  def self.active_escalation_levels(escalatable, attribs = [])
    levels = []
    if attribs.empty?
      attribs = escalatable.escalatable_attributes
    end
    attribs.each do |attrib|
      levels += fetch_escalation_levels(escalatable, attrib)
    end
    levels
  end

private

  def self.fetch_value(escalatable, attrib)
    value = escalatable.send(attrib)
    if value.kind_of?(Time)
      value = ((value - Time.current) / 1.minute).round
    end
    value
  end

  # 1. check for direct assigned escalation levels
  # 2. else check for escalation levels via channel_statistic_group
  # 3. else check if matching default record exists (having escalatable_id: 0)

  def self.fetch_escalation_levels(escalatable, attrib)
    if escalatable.escalation_levels.where(attrib: attrib).any?
      escalatable.escalation_levels.where(attrib: attrib)
    elsif fetch_escalations_from_group(escalatable, attrib).any?
      fetch_escalations_from_group(escalatable, attrib)
    else
      EscalationLevel.where(escalatable_type: escalatable.class.name.to_s,
                            escalatable_id: 0, attrib: attrib)
    end
  end

  def self.fetch_escalations_from_group(escalatable, attrib)
    return [] unless escalatable.kind_of? ChannelStatistic
    escalatable.channel_statistic_groups.map do |g| 
      g.escalation_levels.where(attrib: attrib)
    end.flatten.compact
  end

  def self.fetch_attrib(escalatable, attrib)
    if escalatable.respond_to?(attrib)
      escalatable.send(attrib)
    else
      0
    end
  end
end
