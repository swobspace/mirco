# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelStatisticConcerns, type: :model do
  let(:cs) { FactoryBot.create(:channel_statistic, queued: 53) }

  describe 'without counters' do
    describe '#sent_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.sent_last_30min
        end.not_to raise_error
      end
      it { expect(cs.sent_last_30min).to eq(0) }
    end

    describe '#received_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.received_last_30min
        end.not_to raise_error
      end
      it { expect(cs.received_last_30min).to eq(0) }
    end

    describe '#error_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.error_last_30min
        end.not_to raise_error
      end
      it { expect(cs.error_last_30min).to eq(0) }
    end

    describe '#filtered_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(cs.filtered_last_30min).to eq(0) }
    end
  end

  describe 'with counters present' do
    let!(:cc1) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: cs.id,
                        sent: 100,
                        received: 101,
                        filtered: 102,
                        error: 103,
                        queued: 0,
                        created_at: 10.minutes.before(Time.current))
    end
    let!(:cc2) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: cs.id,
                        sent: 200,
                        received: 202,
                        filtered: 204,
                        error: 206,
                        queued: 5,
                        created_at: 5.minutes.before(Time.current))
    end
    let!(:cc3) do
      FactoryBot.create(:channel_counter,
                        channel_statistic_id: cs.id,
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
          cs.sent_last_30min
        end.not_to raise_error
      end
      it { expect(cs.sent_last_30min).to eq(200) }
    end

    describe '#received_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.received_last_30min
        end.not_to raise_error
      end
      it { expect(cs.received_last_30min).to eq(202) }
    end

    describe '#error_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.error_last_30min
        end.not_to raise_error
      end
      it { expect(cs.error_last_30min).to eq(206) }
    end

    describe '#filtered_last_30min' do
      it "doesn't raise an error" do
        expect do
          cs.filtered_last_30min
        end.not_to raise_error
      end
      it { expect(cs.filtered_last_30min).to eq(204) }
    end
  end

  describe "::escalated" do
    describe "with no escalation level" do
      it { expect(ChannelStatistic.escalated).to eq([]) }
    end

    describe "with nonmatching escalation level" do
      let!(:el) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: cs.id,
          attrib: 'queued',
          max_warning: 100,
          max_critical: 200
        )
      end
      it { expect(ChannelStatistic.escalated).to eq([]) }
    end

    describe "with matching escalation level" do
      let!(:el) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: cs.id,
          attrib: 'queued',
          max_warning: 10,
          max_critical: 50
        )
      end
      it { expect(ChannelStatistic.escalated).to contain_exactly(cs) }
      it { expect(EscalationLevel.check_for_escalation(cs, 'queued')).to eq(2) }
    end
  end
end
