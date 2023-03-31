require 'rails_helper'

RSpec.describe ChannelStatisticsGroup, type: :model do
  let(:channel_statistics_group) { FactoryBot.create(:channel_statistics_group, name: 'RxCWD') }
  it { is_expected.to have_and_belong_to_many(:channel_statistics).inverse_of(:channel_statistics_groups) }
  it { is_expected.to have_many(:escalation_levels).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:channel_statistics_group)
    g = FactoryBot.create(:channel_statistics_group)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:name).case_insensitive
  end

  describe "#to_s" do
    it { expect(channel_statistics_group.to_s).to match('RxCWD') }
  end
end
