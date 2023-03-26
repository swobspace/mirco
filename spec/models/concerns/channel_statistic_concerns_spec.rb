# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelStatisticConcerns, type: :model do
  let!(:cs) do
    FactoryBot.create(:channel_statistic,
      queued: 53, 
      last_message_received_at: 10.minutes.before(Time.now),
      last_message_sent_at: 30.minutes.before(Time.now),
      updated_at: 12.minutes.before(Time.now),
      meta_data_id: 1
    ) 
  end

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
      before(:each) do
        cs.update(condition: cs.escalation_status.state,
                  updated_at: 12.minutes.before(Time.now))
      end

      it { expect(cs.meta_data_id).to eq(1) }
      it { expect(ChannelStatistic.escalated).to contain_exactly(cs) }
      it { expect(EscalationLevel.check_for_escalation(cs, 'queued').state).to eq(2) }
    end
  end

  describe "#escalation_status" do
      let!(:el1) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: cs.id,
          attrib: 'queued',
          max_warning: 50,
          max_critical: 200
        )
      end
      let!(:el2) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: 0,
          attrib: 'queued',
          max_warning: 10,
          max_critical: 50
        )
      end
      let!(:el3) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: cs.id,
          attrib: 'last_message_receive_at',
          min_warning: -15,
          min_critical: -60 
        )
      end
      let!(:el4) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: cs.id,
          attrib: 'last_message_sent_at',
          min_warning: -10,
          min_critical: -20 
        )
      end

      let!(:el5) do
        FactoryBot.create(:escalation_level, 
          escalatable_type: 'ChannelStatistic',
          escalatable_id: 0,
          attrib: 'updated_at',
          min_warning: -10,
          min_critical: -20 
        )
      end

      # maximum escalation level set by last_message_sent_at
      it { expect(cs.escalation_status.state).to eq(EscalationLevel::CRITICAL) }
      # take specific escalation level, not default escalation level
      it { expect(cs.escalation_status('queued').state).to eq(EscalationLevel::WARNING) }
      # use default escalation level for updated_at
      it { expect(cs.escalation_status('updated_at').state).to eq(EscalationLevel::WARNING) }
      it { expect(cs.escalation_status('last_message_sent_at').state).to eq(EscalationLevel::CRITICAL) }
      # no escalation level set for last_message_error_at
      it { expect(cs.escalation_status('last_message_error_at').state).to eq(EscalationLevel::NOTHING) }
  end
end
