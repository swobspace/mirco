# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Alert, type: :model do
  let(:server) { FactoryBot.create(:server) }
  let(:channel) { FactoryBot.create(:channel, server: server) }
  let(:channel_statistic) do
    FactoryBot.create(:channel_statistic, server: server,
                                          channel: channel)
  end
  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel).optional }
  it { is_expected.to belong_to(:channel_statistic).optional }
  it { is_expected.to validate_presence_of(:server_id) }
  it { is_expected.not_to validate_presence_of(:channel_id) }
  it { is_expected.not_to validate_presence_of(:channel_statistic_id) }
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

  it 'sets server_id from channel if missing' do
    f = FactoryBot.build(:alert, server_id: nil, channel_id: channel.id)
    f.save
    expect(f).to be_valid
    f.reload
    expect(f.server_id).to eq(server.id)
  end

  it 'sets channel_id, server_id from channel_statistic if missing' do
    f = FactoryBot.build(:alert, server_id: nil,
                                channel_id: nil,
                                channel_statistic: channel_statistic)
    f.save
    expect(f).to be_valid
    f.reload
    expect(f.server_id).to eq(server.id)
    expect(f.channel_id).to eq(channel.id)
  end

  it "don't save alert if :message.blank?" do
    f = FactoryBot.build(:alert, message: '')
    expect do
      f.save
    end.to change(Note, :count).by(0)
  end

end
