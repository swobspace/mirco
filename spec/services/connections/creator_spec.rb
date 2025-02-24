# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connections::Creator, type: :model do
  let(:properties) do
    YAML.load_file(
      Rails.root.join('spec', 'fixtures', 'files', 'channel_11.yaml')
    )
  end
  let(:location) { FactoryBot.create(:location, lid: 'KNX') }
  let(:channel) { FactoryBot.create(:channel, properties: properties) }
  subject { Connections::Creator.new(channel: channel) }
  before(:each) do
    allow(channel).to receive(:location).and_return(location)
  end

  describe "#connection_attributes" do
    before(:each) do
      allow(channel).to receive(:ipaddress).and_return('1.2.3.4')
      subject.save
    end
    it "sets connection_attributes[0]" do
      expect(subject.connection_attributes[0]).to include(
        'location_id'     => location.id, 
        'channel_ids'     => [channel.id],
        'source_url'      => "tcp://1.2.3.4:6101", 
        'destination_url' => "tcp://172.17.32.97:7200"
      )
    end
    it "sets connection_attributes[1]" do
      expect(subject.connection_attributes[1]).to include(
        'location_id'     => location.id, 
        'channel_ids'     => [channel.id],
        'source_url'      => "tcp://1.2.3.4:6101", 
        'destination_url' => "tcp://172.17.35.56:13005"
      )
    end
  end

  describe "#save" do
    before(:each) do
      allow(channel).to receive(:ipaddress).and_return('1.2.3.4')
    end
    context "without existing connections" do
      it "creates 2 new connections" do
        expect {
          subject.save
        }.to change(SoftwareConnection, :count).by(2)
      end
    end

    context "with one pre-existing connection" do
      let!(:connection) do
        FactoryBot.create(:software_connection,
          location_id: location.id,
          source_url: 'tcp://1.2.3.4:6101',
          destination_url: 'tcp://172.17.35.56:13005',
          channel_ids: [4711,815]
        )
      end
      it "creates only one new connection" do
        expect {
          subject.save
        }.to change(SoftwareConnection, :count).by(1)
      end
      it "updates #channel_ids" do
        subject.save; connection.reload
        expect(connection.channel_ids).to contain_exactly(channel.id)
      end
    end
  end

  describe "with source host == 0.0.0.0|localhost" do
    let(:host) { FactoryBot.create(:host, ipaddress: '192.0.2.83') }
    let(:server) { FactoryBot.create(:server, host: host) }

    before(:each) do
      allow(channel).to receive(:server).and_return(server)
    end

    it "sets server ip (1)" do
      allow(channel).to receive_message_chain(:source_connector, :url).and_return('tcp://0.0.0.0:5678')
      subject.save
      expect(subject.connection_attributes[1]).to include(
        'location_id'     => location.id, 
        'channel_ids'     => [channel.id],
        'source_url'      => "tcp://192.0.2.83:5678", 
        'destination_url' => "tcp://172.17.35.56:13005"
      )
    end

    it "sets server ip (2)" do
      allow(channel).to receive_message_chain(:source_connector, :url).and_return('tcp://localhost:3247')
      subject.save
      expect(subject.connection_attributes[1]).to include(
        'location_id'     => location.id, 
        'channel_ids'     => [channel.id],
        'source_url'      => "tcp://192.0.2.83:3247", 
        'destination_url' => "tcp://172.17.35.56:13005"
      )
    end
  end
  describe "server without host" do
    let(:server) { FactoryBot.create(:server) }
    
    describe "#save" do
      it "missing host does not raise an error" do
        expect {
          subject.save
        }.not_to raise_error
      end

      it "missing location does not raise an error" do
        expect(channel).to receive(:location).and_return(nil)
        expect {
          subject.save
        }.not_to raise_error
      end
    end
  end
end
