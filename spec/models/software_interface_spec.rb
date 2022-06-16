require 'rails_helper'

RSpec.describe SoftwareInterface, type: :model do
  let(:host) do
    FactoryBot.create(:host, 
      hostname: 'SSrv'
    )
  end
  let(:software_interface) do
    FactoryBot.create(:software_interface, 
      host: host,
      name: '.NETHL7',
    )
  end
  it { is_expected.to belong_to(:software) }
  it { is_expected.to belong_to(:host) }
  it { is_expected.to have_many(:interface_connectors).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:software_id) }
  it { is_expected.to have_rich_text(:description) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:software_interface)
    g = FactoryBot.create(:software_interface)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(software_interface.to_s).to match('.NETHL7 (SSrv)') }
  end


end
