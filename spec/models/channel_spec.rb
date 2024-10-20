# frozen_string_literal: true

require 'rails_helper'

class FakeStatus
  attr_reader :state, :message
  def initialize(state, message)
    @state = state
    @message = message
  end
end

RSpec.describe Channel, type: :model do
  let(:channel) do 
    FactoryBot.create(:channel, 
      properties: { 'name': 'special channel',
                    'exportData': { 'metadata': { 'enabled': 'true' }}}
     )
  end
  it { is_expected.to belong_to(:server) }
  it { is_expected.to have_one(:channel_statistic) }
  it { is_expected.to have_many(:channel_statistics).dependent(:destroy) }
  it { is_expected.to have_many(:channel_counters).dependent(:delete_all) }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:all_notes).dependent(:destroy) }
  it { is_expected.to have_many(:escalation_levels).dependent(:destroy) }
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

    describe "scope #active" do
      it { expect(Channel.active).to contain_exactly(ch1) }
    end

    describe "#enabled?" do
      it { expect(ch1.enabled?).to be_truthy }
      it { expect(ch2.enabled?).to be_falsey }
    end

    describe "#disabled?" do
      it { expect(ch1.disabled?).to be_falsey }
      it { expect(ch2.disabled?).to be_truthy }
    end

    describe "#save" do
      it "changes enabled to disabled" do
        ch1.properties = { "exportData" => { "metadata" => { "enabled" => "false" } } }
        ch1.save; ch1.reload
        expect(ch1.enabled?).to be_falsey
      end

      it "changes disabled to enabled" do
        ch2.properties = { "exportData" => { "metadata" => { "enabled" => "true" } } }
        ch2.save; ch2.reload
        expect(ch2.enabled?).to be_truthy
      end

      it "sets enabled if exportData is not available" do
        ch2.properties = nil
        ch2.save; ch2.reload
        expect(ch2.enabled?).to be_falsey
      end

    end
  end

  describe "#update_condition" do
    it { expect(channel.condition).to eq(Mirco::States::OK) }

    describe "with manual check enabled" do
      it "-> NOTHING" do
        expect(channel).to receive(:enabled?).and_return(false)
        expect {
          channel.update_condition
        }.to change(channel, :condition).to(Mirco::States::NOTHING)
      end
    end

    describe "escalation level WARNING" do
      it "-> WARNING" do
        expect(channel).to receive(:escalation_status).at_least(:once).
          and_return(FakeStatus.new(Mirco::States::WARNING, "some text"))
        expect {
          channel.update_condition
        }.to change(channel, :condition).to(Mirco::States::WARNING)
      end
    end
  end
end
