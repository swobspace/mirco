require 'rails_helper'

RSpec.describe NotificationGroup, type: :model do
  let(:notification_group) { FactoryBot.create(:notification_group, name: 'Admins') }
  it { is_expected.to have_and_belong_to_many(:users).class_name('Wobauth::User').inverse_of(:notification_groups) }
  it { is_expected.to have_many(:escalation_levels).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:notification_group)
    g = FactoryBot.create(:notification_group)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:name).case_insensitive
  end

  describe "#to_s" do
    it { expect(notification_group.to_s).to match('Admins') }
  end
end
