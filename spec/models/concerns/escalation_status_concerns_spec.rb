# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EscalationStatusConcerns, type: :model do
  let!(:cs) do
    FactoryBot.create(:channel_statistic,
      queued: 53, 
      last_message_received_at: 10.minutes.before(Time.now),
      last_message_sent_at: 30.minutes.before(Time.now),
      updated_at: 12.minutes.before(Time.now),
      meta_data_id: 1
    ) 
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
      it { expect(cs.escalation_status.message).to eq("CRITICAL(1): last_message_sent_at; WARNING(2): queued, updated_at" ) }
      # take specific escalation level, not default escalation level
      it { expect(cs.escalation_status('queued').state).to eq(EscalationLevel::WARNING) }
      it { expect(cs.escalation_status('queued').message).to eq("WARNING(1): queued" ) }
      # use default escalation level for updated_at
      it { expect(cs.escalation_status('updated_at').state).to eq(EscalationLevel::WARNING) }
      it { expect(cs.escalation_status('updated_at').message).to eq("WARNING(1): updated_at" ) }
      it { expect(cs.escalation_status('last_message_sent_at').state).to eq(EscalationLevel::CRITICAL) }
      it { expect(cs.escalation_status('last_message_sent_at').message).to eq("CRITICAL(1): last_message_sent_at" ) }
      # no escalation level set for last_message_error_at
      it { expect(cs.escalation_status('last_message_error_at').state).to eq(EscalationLevel::NOTHING) }
      it { expect(cs.escalation_status('last_message_error_at').message).to eq("" ) }
  end
end
