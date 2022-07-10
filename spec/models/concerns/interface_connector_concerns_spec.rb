# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SoftwareConnectionConcerns, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'BER') }
  let(:location2) { FactoryBot.create(:location, lid: 'TGL') }
  let(:software) { FactoryBot.create(:software, name: "Baren") }
  let(:host) { FactoryBot.create(:host, ipaddress: '192.0.2.81', location: location) }
  let(:software_interface) do
    FactoryBot.create(:software_interface,
      host: host,
      software: software,
      name: "HL7Comm"
    )
  end
  let!(:rxconn) do
    FactoryBot.create(:interface_connector, 
      name: 'ADT in',
      type: 'RxConnector',
      url: 'tcp://192.0.2.81:1111',
      software_interface: software_interface
    )
  end

  let!(:swconn1) do
    FactoryBot.create(:software_connection,
      location: location,
      destination_connector: rxconn,
      source_url: 'tcp://192.0.2.20:22222',
      destination_url: 'tcp://192.0.2.81:1111',
    )
  end
  let!(:swconn2) do
    FactoryBot.create(:software_connection,
      location: location,
      source_url: 'tcp://192.0.2.44:4444',
      destination_url: 'tcp://192.0.2.81:1111',
    )
  end
  let!(:swconn3) do
    FactoryBot.create(:software_connection,
      location: location,
      source_url: 'tcp://192.0.2.45:4545',
      destination_url: 'tcp://192.0.2.81:1111',
      ignore: true
    )
  end
  let!(:swconn4) do
    FactoryBot.create(:software_connection,
      location: location2,
      source_url: 'tcp://192.0.2.46:4646',
      destination_url: 'tcp://192.0.2.81:1111',
    )
  end

  describe "#direction" do
    it { expect(rxconn.direction).to eq("in") }
  end

  describe "#software_connections" do
    it { expect(rxconn.software_connections).to contain_exactly(swconn1) }
  end

  describe "#possible_connections" do
    it { expect(rxconn.possible_connections).to contain_exactly(swconn2) }
  end

  describe "#nonlocal_possible_connections" do
    it { expect(rxconn.nonlocal_possible_connections).to contain_exactly(swconn4) }
  end
end
