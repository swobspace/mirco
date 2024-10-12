# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Server, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'XAZ') }
  let(:host) do
    FactoryBot.create(:host, 
      location: location,
      name: 'XYZMIRTH.LOCAL', 
      ipaddress: '11.22.33.55'
    )
  end
  let(:server) do 
    FactoryBot.create(:server, 
      host: host,
      name: 'xyzmirth',
      api_url: 'https://11.22.33.55:8443/api'
    ) 
  end
  it { is_expected.not_to belong_to(:location) }
  it { is_expected.to belong_to(:host).optional }
  it { is_expected.to have_many(:software_connections).dependent(:destroy) }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:all_notes).dependent(:destroy) }
  it { is_expected.to have_many(:channels).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:channel_statistics).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:channel_counters).dependent(:destroy) }
  it { is_expected.to have_many(:server_configurations).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:escalation_levels).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:server)
    g = FactoryBot.create(:server)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to validate_uniqueness_of(:uid).case_insensitive
  end

  describe "#to_s" do
    it { expect(server.to_s).to match('xyzmirth') }
  end

  describe "#to_label" do
    it { expect(server.to_label).to eq('xyzmirth / XYZMIRTH.LOCAL (11.22.33.55) / XAZ') }
  end

  describe "#fullname" do
    it { expect(server.fullname).to match('xyzmirth') }
  end

  describe "#ipaddress" do
    it { expect(server.ipaddress).to eq('11.22.33.55') }
  end

  describe "with notes" do
    let!(:note) { FactoryBot.create(:note, notable: server, type: 'note') }
    let!(:ack) { FactoryBot.create(:note, notable: server, type: 'acknowledge') }
    let!(:oldnote) do  
      FactoryBot.create(:note,
        notable: server,
        type: 'note',
        valid_until: Date.yesterday
      )
    end
    let!(:oldack) do
      FactoryBot.create(:note,
        notable: server,
        type: 'acknowledge',
        valid_until: Date.yesterday
      )
    end

    it { expect(server.acknowledges).to contain_exactly(ack, oldack) }
    it { expect(server.current_acknowledge).to eq(ack) }
    it { expect(server.acknowledges.active).to contain_exactly(ack) }
    it { expect(server.acknowledges.count).to eq(2) }
    it { expect(server.current_note).to eq(note) }
    it { expect(server.notes.active).to contain_exactly(note, ack) }
    it { expect(server.notes.count).to eq(4) }
    it { expect(server.plain_notes).to contain_exactly(note, oldnote) }
    it { expect(server.plain_notes.active).to contain_exactly(note) }
    it { expect(server.plain_notes.count).to eq(2) }

    describe "#close_acknowledge" do
      before(:each) do
        server.update(acknowledge_id: ack.id)
        server.reload
      end

      it "terminates current ack" do
        expect(server.acknowledge).to eq(ack)
        expect {
          server.close_acknowledge
        }.to change(server, :acknowledge_id).to(nil)
      end
    end
  end

end
