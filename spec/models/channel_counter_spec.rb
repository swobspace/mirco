# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelCounter, type: :model do
  let(:server) { FactoryBot.create(:server) }
  let(:channel) { FactoryBot.create(:channel, server_id: server.id) }
  let(:channel_counters) { channel.channel_counters }

  it { is_expected.to belong_to(:server) }
  it { is_expected.to belong_to(:channel) }
  it { is_expected.to belong_to(:channel_statistic) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:channel_counter)
    g = FactoryBot.create(:channel_counter)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe '#increase' do
    let!(:cc1) do
      FactoryBot.create(:channel_counter,
                        server_id: server.id, channel_id: channel.id,
                        received: 101,
                        sent: 150,
                        error: 132,
                        filtered: 143,
                        created_at: 10.minutes.before(Time.current))
    end
    let!(:cc2) do
      FactoryBot.create(:channel_counter,
                        server_id: server.id, channel_id: channel.id,
                        received: 202,
                        sent: 250,
                        error: 234,
                        filtered: 246,
                        created_at: 5.minutes.before(Time.current))
    end
    let!(:cc3) do
      FactoryBot.create(:channel_counter,
                        server_id: server.id, channel_id: channel.id,
                        received: 303,
                        sent: 350,
                        error: 336,
                        filtered: 349)
    end

    it 'computes delta for :sent' do
      expect(
        channel_counters.last_hour.increase.map(&:delta)
      ).to contain_exactly(nil, 100, 100)
    end

    it 'computes delta for :received' do
      expect(
        channel_counters.last_hour.increase(value: 'received').map(&:delta)
      ).to contain_exactly(nil, 101, 101)
    end

    it 'computes delta for :error' do
      expect(
        channel_counters.last_hour.increase(value: 'error').map(&:delta)
      ).to contain_exactly(nil, 102, 102)
    end

    it 'computes delta for :filtered' do
      expect(
        channel_counters.last_hour.increase(value: 'filtered').map(&:delta)
      ).to contain_exactly(nil, 103, 103)
    end
  end
end
