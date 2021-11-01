require 'rails_helper'

RSpec.describe Note, type: :model do
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel).optional }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_inclusion_of(:type).in_array(Note::TYPES) }


  it "should get plain factory working" do
    f = FactoryBot.create(:note)
    g = FactoryBot.create(:note)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "#to_s renders string" do
    f = FactoryBot.create(:note, type: 'acknowledge', message: '<p>some other text<p>')
    expect(f.to_s).to eq("#{f.created_at.localtime.to_formatted_s(:db)} #{f.server}::#{f.channel} ACKNOWLEDGE - some other text")
  end

end
