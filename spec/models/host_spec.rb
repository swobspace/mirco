require 'rails_helper'

RSpec.describe Host, type: :model do
  let(:host) { FactoryBot.create(:host, name: 'BND05a', ipaddress: '192.0.2.13') }
  it { is_expected.to belong_to(:location) }
  it { is_expected.to belong_to(:software_group) }
  it { is_expected.to have_many(:servers).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:software_interfaces).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:location_id) }
  it { is_expected.to validate_presence_of(:software_group_id) }
  it { is_expected.to have_rich_text(:description) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:host)
    g = FactoryBot.create(:host)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(host.to_s).to match('BND05a (192.0.2.13)') }
  end

end
