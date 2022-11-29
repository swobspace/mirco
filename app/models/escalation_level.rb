class EscalationLevel < ApplicationRecord
  belongs_to :escalatable, polymorphic: true
end
