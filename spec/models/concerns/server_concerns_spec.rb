# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerConcerns, type: :model do
  describe '#active_channels' do
    context 'with current channel' do
      let(:server) { FactoryBot.create(:server, last_channel_update: Time.current) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.active_channels.count).to eq(1) }
      it { expect(server.channels.count).to eq(1) }
    end
    context 'with old channel' do
      let(:server) { FactoryBot.create(:server, last_channel_update: 1.hour.after(Time.current)) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.active_channels.count).to eq(0) }
      it { expect(server.channels.count).to eq(1) }
    end
    context 'with last_channel_update = nil' do
      let(:server) { FactoryBot.create(:server) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.active_channels.count).to eq(1) }
      it { expect(server.channels.count).to eq(1) }
    end
  end

  describe '#obsolete_channels' do
    context 'with current channel' do
      let(:server) { FactoryBot.create(:server, last_channel_update: Time.current) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.obsolete_channels.count).to eq(0) }
      it { expect(server.channels.count).to eq(1) }
    end
    context 'with old channel' do
      let(:server) { FactoryBot.create(:server, last_channel_update: 1.day.after(Time.current)) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.obsolete_channels.count).to eq(1) }
      it { expect(server.channels.count).to eq(1) }
    end
    context 'with last_channel_update = nil' do
      let(:server) { FactoryBot.create(:server) }
      let!(:channel) { FactoryBot.create(:channel, server_id: server.id) }
      it { expect(server.obsolete_channels.count).to eq(0) }
      it { expect(server.channels.count).to eq(1) }
    end
  end
end
