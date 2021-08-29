require 'rails_helper'

RSpec.describe ChannelCounter, type: :model do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
end
