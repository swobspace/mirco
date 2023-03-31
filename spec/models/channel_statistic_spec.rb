# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelStatistic, type: :model do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'Some Statistics') }
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to have_many(:channel_counters).dependent(:delete_all) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:escalation_levels) }
  it { is_expected.to have_and_belong_to_many(:channel_statistic_groups).inverse_of(:channel_statistics) }

  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_presence_of(:channel_id) }
  it { is_expected.to validate_presence_of(:server_uid) }
  it { is_expected.to validate_presence_of(:channel_uid) }
  it { is_expected.to validate_numericality_of(:condition).is_in(EscalationLevel::STATES).allow_nil }


  it 'should get plain factory working' do
    f = FactoryBot.create(:channel_statistic)
    g = FactoryBot.create(:channel_statistic)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:meta_data_id).scoped_to(%i[server_id channel_id]).allow_nil
    is_expected.to validate_uniqueness_of(:channel_uid).scoped_to(%i[server_id meta_data_id])
    is_expected.to validate_uniqueness_of(:channel_id).scoped_to(%i[server_id meta_data_id])
  end

  describe "#to_s" do
    it { expect(cs.to_s).to eq("Some Statistics") }
  end

  describe "#fullname" do
    it { expect(cs.fullname).to match("#{cs.server.to_s} > #{cs.channel.to_s} > Some Statistics") }
  end

  describe "#save" do
    let!(:cs) { FactoryBot.create(:channel_statistic, received: 100, sent: 50, error: 1) }
    let!(:ts) { DateTime.current + 20.minutes }
    it { expect(cs.last_message_received_at).to be_nil }
    it { expect(cs.last_message_sent_at).to be_nil }
    it { expect(cs.last_message_error_at).to be_nil }
    describe "updates #last_message_*" do
      before(:each) do
        travel_to ts
      end
      after(:each) do
        travel_back
      end

      it "received_at changed" do
        cs.update(received: 101)
        expect(cs.last_message_received_at.to_i).to eq(ts.to_i)
      end
      it "sent_at changed" do
        cs.update(sent: 51)
        expect(cs.last_message_sent_at.to_i).to eq(ts.to_i)
      end
      it "error_at changed" do
        cs.update(error: 3)
        expect(cs.last_message_error_at.to_i).to eq(ts.to_i)
      end
    end
  end

  describe "enabled" do
    let!(:ch1) do
      FactoryBot.create(:channel, enabled: true, 
        properties: { "exportData" => { "metadata" => { "enabled" => "true" } } }
      )
    end
    let!(:ch2) do
      FactoryBot.create(:channel, enabled: false, 
        properties: { "exportData" => { "metadata" => { "enabled" => "false" } } }
      )
    end
    let!(:cs1) do 
      FactoryBot.create(:channel_statistic, channel: ch1)
    end
    let!(:cs2) do 
      FactoryBot.create(:channel_statistic, channel: ch2)
    end

    describe "scope #active" do
      it { expect(ChannelStatistic.active).to contain_exactly(cs1) }
    end
  end

end
