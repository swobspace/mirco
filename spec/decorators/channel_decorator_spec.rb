# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelDecorator do
  let(:server)  { FactoryBot.create(:server) }
  let(:channel) { FactoryBot.create(:channel, server_id: server.id) }
  let(:ch)      { channel.decorate }

  describe 'without counters' do
    let(:ch) { channel.decorate }
    describe '#sent_last_30min' do
      it "doesn't raise an error" do
        expect do
          ch.sent_last_30min
        end.not_to raise_error
      end
      it { expect(ch.sent_last_30min).to eq(0) }
    end

    describe '#received_last_30min' do
      let(:channel) { FactoryBot.create(:channel) }
      it "doesn't raise an error" do
        expect do
          ch.received_last_30min
        end.not_to raise_error
      end
      it { expect(ch.received_last_30min).to eq(0) }
    end

    describe '#error_last_30min' do
      let(:channel) { FactoryBot.create(:channel) }
      it "doesn't raise an error" do
        expect do
          ch.error_last_30min
        end.not_to raise_error
      end
      it { expect(ch.error_last_30min).to eq(0) }
    end

    describe '#filtered_last_30min' do
      let(:channel) { FactoryBot.create(:channel) }
      it "doesn't raise an error" do
        expect do
          ch.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(ch.filtered_last_30min).to eq(0) }
    end
  end

  describe 'with counters present' do
    let!(:cc1) do
      FactoryBot.create(:channel_counter,
                        channel_id: channel.id, server_id: channel.server.id,
                        sent: 100,
                        received: 101,
                        filtered: 102,
                        error: 103,
                        queued: 0,
                        created_at: 10.minutes.before(Time.now))
    end
    let!(:cc2) do
      FactoryBot.create(:channel_counter,
                        channel_id: channel.id, server_id: channel.server.id,
                        sent: 200,
                        received: 202,
                        filtered: 204,
                        error: 206,
                        queued: 5,
                        created_at: 5.minutes.before(Time.now))
    end
    let!(:cc3) do
      FactoryBot.create(:channel_counter,
                        channel_id: channel.id, server_id: channel.server.id,
                        sent: 300,
                        received: 303,
                        filtered: 306,
                        error: 309,
                        queued: 5,
                        created_at: Time.now)
    end
    describe '#sent_last_30min' do
      let(:channel) { FactoryBot.create(:channel) }
      it "doesn't raise an error" do
        expect do
          ch.sent_last_30min
        end.not_to raise_error
      end
      it { expect(ch.sent_last_30min).to eq(200) }
    end

    describe '#received_last_30min' do
      it "doesn't raise an error" do
        expect do
          ch.received_last_30min
        end.not_to raise_error
      end
      it { expect(ch.received_last_30min).to eq(202) }
    end

    describe '#error_last_30min' do
      it "doesn't raise an error" do
        expect do
          ch.error_last_30min
        end.not_to raise_error
      end
      it { expect(ch.error_last_30min).to eq(206) }
    end

    describe '#filtered_last_30min' do
      it "doesn't raise an error" do
        expect do
          ch.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(ch.filtered_last_30min).to eq(204) }
    end
  end
end
