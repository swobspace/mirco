# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelStatisticConcerns, type: :model do
  let(:channel_statistic) { FactoryBot.create(:channel_statistic) }

  describe 'without counters' do
    describe '#sent_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.sent_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.sent_last_30min).to eq(0) }
    end

    describe '#received_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.received_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.received_last_30min).to eq(0) }
    end

    describe '#error_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.error_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.error_last_30min).to eq(0) }
    end

    describe '#filtered_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.filtered_last_30min).to eq(0) }
    end
  end

  describe 'with counters present' do
    let!(:cc1) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: channel_statistic.id,
                        sent: 100,
                        received: 101,
                        filtered: 102,
                        error: 103,
                        queued: 0,
                        created_at: 10.minutes.before(Time.current))
    end
    let!(:cc2) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: channel_statistic.id,
                        sent: 200,
                        received: 202,
                        filtered: 204,
                        error: 206,
                        queued: 5,
                        created_at: 5.minutes.before(Time.current))
    end
    let!(:cc3) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: channel_statistic.id,
                        sent: 300,
                        received: 303,
                        filtered: 306,
                        error: 309,
                        queued: 5,
                        created_at: Time.current)
    end
    describe '#sent_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.sent_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.sent_last_30min).to eq(200) }
    end

    describe '#received_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.received_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.received_last_30min).to eq(202) }
    end

    describe '#error_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.error_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.error_last_30min).to eq(206) }
    end

    describe '#filtered_last_30min' do
      it "doesn't raise an error" do
        expect do
          channel_statistic.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(channel_statistic.filtered_last_30min).to eq(204) }
    end
  end
end
