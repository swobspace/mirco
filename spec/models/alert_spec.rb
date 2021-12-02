# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Alert, type: :model do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_presence_of(:channel_id) }
  it { is_expected.to validate_inclusion_of(:type).in_array(Alert::TYPES) }
  it { is_expected.to validate_presence_of(:message) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:alert)
    g = FactoryBot.create(:alert)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it '#to_s renders string' do
    f = FactoryBot.create(:alert, type: 'recovery', message: 'some other text')
    expect(f.to_s).to eq("#{f.server}::#{f.channel} RECOVERY - some other text")
  end
end
