class ChannelCounter < ApplicationRecord
  belongs_to :channel
  belongs_to :server
end
