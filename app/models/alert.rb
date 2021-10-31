class Alert < ApplicationRecord
  belongs_to :server
  belongs_to :channel
end
