require 'rails_helper'

RSpec.describe ChannelStatistic, type: :model do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to have_many(:channel_counters).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_presence_of(:channel_id) }
  it { is_expected.to validate_presence_of(:server_uid) }
  it { is_expected.to validate_presence_of(:channel_uid) }

  it "should get plain factory working" do
    f = FactoryBot.create(:channel_statistic)
    g = FactoryBot.create(:channel_statistic)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:meta_data_id).scoped_to([:server_id, :channel_id]).allow_nil
    is_expected.to validate_uniqueness_of(:channel_uid).scoped_to([:server_id, :meta_data_id])
    is_expected.to validate_uniqueness_of(:channel_id).scoped_to([:server_id, :meta_data_id ])
  end

end
