require 'rails_helper'
require 'ipaddr'

RSpec.describe InterfaceConnector, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'QUK') }
  let(:software) { FactoryBot.create(:software, name: "QUAKKA") }
  let(:host) { FactoryBot.create(:host, ipaddress: '99.88.77.66', location: location) }
  let(:software_interface) do
    FactoryBot.create(:software_interface, 
      host: host,
      software: software,
      name: "IM4HC"
    )
  end
  let(:interface_connector) do
    FactoryBot.create(:interface_connector,
      name: 'BAR in',
      type: 'TxConnector',
      url: 'tcp://0.0.0.0:5555',
      software_interface: software_interface
    )
  end
  it { is_expected.to belong_to(:software_interface) }
  it { pending; is_expected.to have_many(:hl7_events).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:source_connections).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:destination_connections).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:software_interface_id) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to have_rich_text(:description) }
  it { is_expected.to validate_inclusion_of(:type).in_array(InterfaceConnector::TYPES) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:interface_connector)
    g = FactoryBot.create(:interface_connector)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(interface_connector.to_s).to match('BAR in (tcp://99.88.77.66:5555)') }
  end

  describe "#to_label" do
    it { expect(interface_connector.to_label).to eq('BAR in (tcp://99.88.77.66:5555) > QUAKKA/IM4HC > QUK') }
  end

  describe "#direction" do
    it { expect(interface_connector.direction).to eq('out') }
  end

  describe "#scheme" do
    it { expect(interface_connector.scheme).to eq('tcp') }
  end

  describe "#host" do
    it { expect(interface_connector.host).to eq('99.88.77.66') }
  end

  describe "#ipaddress" do
    it { expect(interface_connector.ipaddress.to_s).to eq('99.88.77.66') }
  end

  describe "#port" do
    it { expect(interface_connector.port).to eq(5555) }
  end

  describe "#if_name" do
    it { expect(interface_connector.if_name).to eq(interface_connector.software_interface.name) }
  end

  describe "#sw_name" do
    it { expect(interface_connector.sw_name).to eq(interface_connector.software_interface.software.name) }
  end

  describe "#save" do
    let(:ip) { IPAddr.new("12.34.56.78") }
    it "replace 0.0.0.0 by ipaddress of software_interface if present" do
      allow(software_interface).to receive(:ipaddress).and_return(ip)
      software_interface.save; software_interface.reload
      expect(interface_connector.ipaddress.to_s).to eq("12.34.56.78")
    end
  end

end
