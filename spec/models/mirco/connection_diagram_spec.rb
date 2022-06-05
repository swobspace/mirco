# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mirco::ConnectionDiagram, type: :model do
  let(:loc) { FactoryBot.create(:location, lid: 'LXX') }
  let(:src) { FactoryBot.create(:interface_connector, name: "SrcConnector", type: "TxConnector") }
  let(:dst) { FactoryBot.create(:interface_connector, name: "DstConnector", type: "RxConnector") }
  let!(:connection) do 
    FactoryBot.create(:software_connection,
      location_id: loc.id,
      source_connector_id: src.id,
      source_url: src.url,
      destination_connector_id: dst.id,
      destination_url: dst.url
    )
  end

  it "test" do 
    skip "just for debugging" 
    puts dst.inspect
    puts connection.inspect
    puts connection.source_connector.to_s
    puts connection.destination_connector.to_s 
  end

  subject { Mirco::ConnectionDiagram.new(connection) }

  it {
    expect(subject.path).to eq(
      Rails.root.to_s + "/tmp/cache/connections/connection_#{connection.id}"
    )
  }
  it {
    expect(subject.filename(:puml)).to eq(
      Rails.root.to_s + "/tmp/cache/connections/connection_#{connection.id}.puml"
    )
  }
  it { expect(subject.basename).to eq("connection_#{connection.id}") }

  describe '#mk_cachedir' do
    it 'creates cache directory' do
      subject.mk_cachedir
      expect(File.exist?(subject.cachedir)).to be_truthy
    end
  end

  describe '#create' do
    after(:each) do
      subject.delete
    end

    it 'creates puml file' do
      subject.create(:svg)

      puts subject.filename(:puml)
      expect(File.exist?(subject.filename(:puml))).to be_truthy
      expect(File.exist?(subject.filename(:svg))).to be_truthy
    end
  end
end
