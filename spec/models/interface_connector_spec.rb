require 'rails_helper'

RSpec.describe InterfaceConnector, type: :model do
  let(:interface_connector) do
    FactoryBot.create(:interface_connector,
      name: 'BAR in',
      type: 'TxConnector',
      url: 'tcp://0.0.0.0:5555'
    )
  end
  it { is_expected.to belong_to(:software_interface) }
  it { pending; is_expected.to have_many(:hl7_events).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:software_interface_id) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to have_rich_text(:description) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:interface_connector)
    g = FactoryBot.create(:interface_connector)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(interface_connector.to_s).to match('BAR in (tcp://0.0.0.0:5555)') }
  end

  describe "#direction" do
    it { expect(interface_connector.direction).to eq('out') }
  end

  describe "#scheme" do
    it { expect(interface_connector.scheme).to eq('tcp') }
  end

  describe "#host" do
    it { expect(interface_connector.host).to eq('0.0.0.0') }
  end

  describe "#port" do
    it { expect(interface_connector.port).to eq(5555) }
  end

end
