# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:server) { FactoryBot.create(:server) }
  let(:channel) { FactoryBot.create(:channel, server: server) }
  let(:user) { FactoryBot.create(:user) }
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel).optional }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.to validate_inclusion_of(:type).in_array(Note::TYPES) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:note)
    g = FactoryBot.create(:note)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it '#to_s renders string' do
    f = FactoryBot.create(:note, type: 'acknowledge', message: '<p>some other text<p>')
    expect(f.to_s).to eq("#{f.created_at.localtime.to_formatted_s(:db)} #{f.server}::#{f.channel} ACKNOWLEDGE - some other text")
  end

  it 'sets server_id from channel if missing' do
    f = FactoryBot.build(:note, server_id: nil, channel_id: channel.id, user_id: user.id)
    f.save
    expect(f).to be_valid
    f.reload
    expect(f.server_id).to eq(server.id)
  end

  it "don't save note if :message.blank?" do
    f = FactoryBot.build(:note, message: '')
    expect do
      f.save
    end.to change(Note, :count).by(0)
  end
end
