require 'rails_helper'

RSpec.describe Server, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it "should get plain factory working" do
    f = FactoryBot.create(:server)
    g = FactoryBot.create(:server)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to validate_uniqueness_of(:uid).case_insensitive
  end

  it "to_s returns value" do
    f = FactoryBot.create(:server, name: "xyzmirth")
    expect("#{f}").to match ("xyzmirth")
  end

end
