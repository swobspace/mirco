require 'rails_helper'

RSpec.describe SoftwareGroup, type: :model do
  let(:software_group) { FactoryBot.create(:software_group, name: 'Radiology') }
  it { is_expected.to have_many(:hosts).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:software).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:software_group)
    g = FactoryBot.create(:software_group)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:name).case_insensitive
  end

  describe "#to_s" do
    it { expect(software_group.to_s).to match('Radiology') }
  end


end
