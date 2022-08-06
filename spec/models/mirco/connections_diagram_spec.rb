# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mirco::ConnectionsDiagram, type: :model do
  let(:loc) { FactoryBot.create(:location, lid: 'LXX') }
  let(:server) { FactoryBot.create(:server) }
  let(:src) { FactoryBot.create(:interface_connector, name: "SrcConnector", type: "TxConnector") }
  let(:dst) { FactoryBot.create(:interface_connector, name: "DstConnector", type: "RxConnector") }
  let!(:connection) do 
    FactoryBot.create(:software_connection,
      location_id: loc.id,
      server_id: server.id,
      source_connector_id: src.id,
      source_url: src.url,
      destination_connector_id: dst.id,
      destination_url: dst.url,
      updated_at: Time.now
    )
  end
  let!(:connection2) do 
    FactoryBot.create(:software_connection,
      location_id: loc.id,
      server_id: server.id,
      source_connector_id: src.id,
      source_url: src.url,
      destination_connector_id: nil,
      destination_url: 'tcp://22.33.44.88:5678',
      updated_at: Time.now
    )
  end

  it "test" do 
    skip "just for debugging" 
    puts dst.inspect
    puts connection.inspect
    puts connection.source_connector.to_s
    puts connection.destination_connector.to_s 
  end

  subject { Mirco::ConnectionsDiagram.new([connection, connection2]) }

  it {
    expect(subject.path).to eq(
      Rails.root.to_s + "/tmp/cache/connections/connections_#{connection.id}-#{connection2.id}"
    )
  }
  it {
    expect(subject.filename(:puml)).to eq(
      Rails.root.to_s + "/tmp/cache/connections/connections_#{connection.id}-#{connection2.id}.puml"
    )
  }
  it { expect(subject.basename).to eq("connections_#{connection.id}-#{connection2.id}") }

  describe '#mk_cachedir' do
    it 'creates cache directory' do
      subject.mk_cachedir
      expect(File.exist?(subject.cachedir)).to be_truthy
    end
  end

  describe '#create' do
    before(:each) do
      subject.create(:svg)
    end
    after(:each) do
      subject.delete
    end

    it 'creates puml file' do
      expect(File.exist?(subject.filename(:puml))).to be_truthy
      expect(File.exist?(subject.filename(:svg))).to be_truthy
    end

    it "new initialisation won't delete files" do
      diag1 = Mirco::ConnectionsDiagram.new([connection, connection2])
      expect(File.exist?(diag1.filename(:puml))).to be_truthy
      expect(File.exist?(diag1.filename(:svg))).to be_truthy
    end

    it "new initialisation after connection change does delete existing files" do
      sleep 1
      connection.touch
      newdiag = Mirco::ConnectionsDiagram.new([connection, connection2])
      expect(File.exist?(newdiag.filename(:puml))).to be_falsey
      expect(File.exist?(newdiag.filename(:svg))).to be_falsey
    end
  end
end
