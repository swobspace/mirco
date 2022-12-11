class NullEscalationLevel
  attr_reader :escalatable_id, :escalatable_type, :attrib, 
              :min_critical, :min_warning, :max_warning, :max_critical

  def initialize(escalatable, attrib)
    @escalatable_id = escalatable.id
    @escalatable_type = escalatable.class.name.to_s
    @attrib = attrib
    @min_critical = @min_warning = @max_warning = @max_critical = nil
  end
end
