require 'rails_helper'

RSpec.describe Software, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'BER') }
  let(:software) { FactoryBot.create(:software, name: 'MySoft', location: location) }
  it { is_expected.to have_many(:software_interfaces).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:interface_connectors).through(:software_interfaces) }
  it { is_expected.to belong_to(:location) }
  it { is_expected.to belong_to(:software_group) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:location_id) }
  it { is_expected.to have_rich_text(:description) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:software)
    g = FactoryBot.create(:software)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(software.to_s).to match('MySoft (BER)') }
  end

end
