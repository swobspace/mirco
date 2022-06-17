require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'ACM', name: 'ACME Main') }

  it { is_expected.to have_many(:hosts).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:software_connections).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:software).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:servers).through(:hosts).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:lid) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:location)
    g = FactoryBot.create(:location)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:lid).case_insensitive
  end

  describe "#to_s" do
    it { expect(location.to_s).to match('ACM: ACME Main') }
  end

end
