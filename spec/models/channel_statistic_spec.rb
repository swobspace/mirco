require 'rails_helper'

RSpec.describe ChannelStatistic, type: :model do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_presence_of(:channel_id) }
  it { is_expected.to validate_presence_of(:server_uid) }
  it { is_expected.to validate_presence_of(:channel_uid) }

  it "should get plain factory working" do
    f = FactoryBot.create(:channel_statistic)
    g = FactoryBot.create(:channel_statistic)
    expect(f).to be_valid
    expect(g).to be_valid
  end

end
