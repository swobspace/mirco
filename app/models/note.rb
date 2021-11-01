class Note < ApplicationRecord
  belongs_to :server
  belongs_to :channel
  belongs_to :user
end
