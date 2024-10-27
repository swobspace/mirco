# frozen_string_literal: true

require 'rails_helper'

class FakeStatus
  attr_reader :state, :message
  def initialize(state, message)
    @state = state
    @message = message
  end
end
  
RSpec.describe ChannelStatistic, type: :model do
  let(:ch) { FactoryBot.create(:channel) }
  let(:cs) do 
    FactoryBot.create(:channel_statistic, 
      name: 'Some Statistics', 
      channel: ch
    )
  end

  before(:each) do
    allow(ch).to receive(:enabled?).and_return(true)
  end

  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to belong_to(:acknowledge).optional }
  it { is_expected.to have_many(:channel_counters).dependent(:delete_all) }
  it { is_expected.to have_many(:all_notes).dependent(:destroy) }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:escalation_levels).dependent(:destroy) }
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

  describe "with notes" do
    let!(:note) { FactoryBot.create(:note, notable: cs, type: 'note') }
    let!(:ack) { FactoryBot.create(:note, notable: cs, type: 'acknowledge') }
    let!(:oldnote) do  
      FactoryBot.create(:note,
        notable: cs,
        type: 'note',
        valid_until: Date.yesterday
      )
    end
    let!(:oldack) do
      FactoryBot.create(:note,
        notable: cs,
        type: 'acknowledge',
        valid_until: Date.yesterday
      )
    end

    it { expect(cs.acknowledges).to contain_exactly(ack, oldack) }
    it { expect(cs.current_acknowledge).to eq(ack) }
    it { expect(cs.acknowledges.active).to contain_exactly(ack) }
    it { expect(cs.acknowledges.count).to eq(2) }
    it { expect(cs.current_note).to eq(note) }
    it { expect(cs.notes.active).to contain_exactly(note, ack) }
    it { expect(cs.notes.count).to eq(4) }
    it { expect(cs.plain_notes).to contain_exactly(note, oldnote) }
    it { expect(cs.plain_notes.active).to contain_exactly(note) }
    it { expect(cs.plain_notes.count).to eq(2) }

    describe "#close_acknowledge" do
      before(:each) do
        cs.update(acknowledge_id: ack.id)
        cs.reload
      end

      it "terminates current ack" do
        expect(cs.acknowledge).to eq(ack)
        expect {
          cs.close_acknowledge
        }.to change(cs, :acknowledge_id).to(nil)
      end
    end
  end

  describe "#update_condition" do
    it { expect(cs.condition).to eq(Mirco::States::WARNING) }

    describe "with channel disabled" do
      it "-> NOTHING" do
        cs.update_column(:condition, Mirco::States::OK)
        cs.reload
        expect(cs.condition).to eq(Mirco::States::OK)
        expect(cs).to receive_message_chain(:channel, :enabled?).and_return(false)
        expect {
          cs.update_condition
        }.to change(cs, :condition).to(Mirco::States::NOTHING)
      end
    end

    describe "with connector stopped" do
      it { expect(ch.enabled?).to be_truthy }
      it { expect(cs.started?).to be_falsey }
      it "-> WARNING" do
        cs.update_columns(condition: Mirco::States::OK, state: 'STOPPED')
        expect(cs.condition).to eq(Mirco::States::OK)
        expect(cs).to receive_message_chain(:channel, :enabled?).and_return(true)
        expect {
          cs.update_condition
        }.to change(cs, :condition).to(Mirco::States::WARNING)
      end
    end

    describe "escalation level CRITICAL" do
      it "-> CRITICAL" do
        expect(cs).to receive(:escalation_status).at_least(:once).
          and_return(FakeStatus.new(Mirco::States::CRITICAL, "some text"))
        expect(ch).to receive(:enabled?).at_least(:once).and_return(true)
        expect(cs).to receive(:started?).at_least(:once).and_return(true)
        expect {
          cs.update_condition
        }.to change(cs, :condition).to(Mirco::States::CRITICAL)
      end
    end
  end

  describe "#save" do
    describe "with changed soap_request_success" do
      it "updates condition" do
        expect(cs.condition).to eq(Mirco::States::WARNING)
        expect(ch).to receive(:enabled?).at_least(:once).and_return(true)
        expect(cs).to receive(:started?).at_least(:once).and_return(true)
        expect {
          cs.save
        }.to change(cs, :condition).to(Mirco::States::OK)
      end
    end
  end
end
