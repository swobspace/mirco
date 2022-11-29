require 'rails_helper'

RSpec.describe EscalationLevel, type: :model do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'Some Statistics') }

  it { is_expected.to belong_to(:escalatable) }
  it { is_expected.to validate_presence_of(:escalatable_id) }
  it { is_expected.to validate_presence_of(:escalatable_type) }
  it { is_expected.to validate_presence_of(:attrib) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')
    g = FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:escalatable_id).scoped_to(%i[escalatable_type attrib])
  end

  describe "::check_for_escalation" do
    describe "attrib = last_message_received_at" do
      subject {EscalationLevel.check_for_escalation(cs, 'last_message_received_at')}

      it { expect(subject).to eq(0) }
    end
  end

end
