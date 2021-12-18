# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel, type: :model do
  let(:channel) { FactoryBot.create(:channel, properties: { name: 'special channel' }) }
  it { is_expected.to belong_to(:server) }
  it { is_expected.to have_one(:channel_statistic).dependent(:destroy) }
  it { is_expected.to have_many(:channel_counters).dependent(:destroy) }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:uid) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:channel)
    g = FactoryBot.create(:channel)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:uid).scoped_to(:server_id)
  end

  describe "#to_s" do
    it { expect(channel.to_s).to match('special channel') }
  end

  describe "#fullname" do
    it { expect(channel.fullname).to match("#{channel.server.to_s} > special channel") }
  end
end
