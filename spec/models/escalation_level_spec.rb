require 'rails_helper'

RSpec.describe EscalationLevel, type: :model do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'Some Statistics') }

  it { is_expected.to belong_to(:escalatable).optional }
  it { is_expected.to validate_presence_of(:escalatable_id) }
  it { is_expected.to validate_presence_of(:escalatable_type) }
  it { is_expected.to validate_presence_of(:attrib) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')
    g = FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:escalatable_id).scoped_to(%i[escalatable_type attrib])
  end

  describe "::check_for_escalation" do
    let!(:ts) { Time.current }

    describe "with unknown attribute" do
      it { expect(EscalationLevel.check_for_escalation(cs, 'notexistent')).to eq(3) }
    end

    describe "attrib = last_message_received_at" do
      subject {EscalationLevel.check_for_escalation(cs, 'last_message_received_at')}

      describe "with no escalation levels" do
        it { expect(subject).to eq(0) }
      end

      describe "with default escalation levels" do
        let!(:el_default) do 
          EscalationLevel.create!(
            escalatable_id: 0,
            escalatable_type: 'ChannelStatistic',
            attrib: 'last_message_received_at',
            min_critical: -1440,
            min_warning: -240,
            max_warning: 240,
            max_critical: 480
          )
        end

        it "CRITICAL if 2 days old" do
          cs.update(last_message_received_at: 2.days.before(ts))
          expect(subject).to eq(2)
        end

        it "WARNING less than 1 day old" do
          cs.update(last_message_received_at: 23.hours.before(ts))
          expect(subject).to eq(1)
        end

        it "OK less than 1h old" do
          cs.update(last_message_received_at: 50.minutes.before(ts))
          expect(subject).to eq(0)
        end

        it "WARNING 5h newer" do
          cs.update(last_message_received_at: 5.hours.after(ts))
          expect(subject).to eq(1)
        end

        it "CRITICAL 2d newer" do
          cs.update(last_message_received_at: 2.days.after(ts))
          expect(subject).to eq(2)
        end

        describe "and specific escalation levels" do
          let!(:el_specific) do 
            EscalationLevel.create!(
              escalatable_id: cs.id,
              escalatable_type: 'ChannelStatistic',
              attrib: 'last_message_received_at',
              min_warning: -480,
            )
          end

          it "CRITICAL if 2 days old" do
            cs.update(last_message_received_at: 2.days.before(ts))
            expect(subject).to eq(1)
          end

          it "WARNING less than 1 day old" do
            cs.update(last_message_received_at: 23.hours.before(ts))
            expect(subject).to eq(1)
          end

          it "OK less than 1h old" do
            cs.update(last_message_received_at: 50.minutes.before(ts))
            expect(subject).to eq(0)
          end

          it "WARNING 5h newer" do
            cs.update(last_message_received_at: 5.hours.after(ts))
            expect(subject).to eq(0)
          end

          it "CRITICAL 2d newer" do
            cs.update(last_message_received_at: 2.days.after(ts))
            expect(subject).to eq(0)
          end
        end

      end
    end

    describe "attrib = last_message_received_at" do
      subject {EscalationLevel.check_for_escalation(cs, 'queued')}

      describe "with no escalation levels" do
        it { expect(subject).to eq(0) }
      end

      describe "with default escalation levels" do
        let!(:el_default) do 
          EscalationLevel.create!(
            escalatable_id: 0,
            escalatable_type: 'ChannelStatistic',
            attrib: 'queued',
            max_warning: 10,
            max_critical: 50 
          )
        end

        it "OK if < 10 " do
          cs.update(queued: 5)
          expect(subject).to eq(0)
        end

        it "WARNING if < 50" do
          cs.update(queued: 25)
          expect(subject).to eq(1)
        end

        it "CRITICAL if > 50" do
          cs.update(queued: 81)
          expect(subject).to eq(2)
        end

        describe "and specific escalation levels" do
          let!(:el_specific) do 
            EscalationLevel.create!(
              escalatable_id: cs.id,
              escalatable_type: 'ChannelStatistic',
              attrib: 'queued',
              max_warning: 5
            )
          end

          it "OK if < 5 " do
            cs.update(queued: 2)
            expect(subject).to eq(0)
          end

          it "WARNING if = 30 " do
            cs.update(queued: 30)
            expect(subject).to eq(1)
          end

          it "WARNING if =81 " do
            cs.update(queued: 81)
            expect(subject).to eq(1)
          end
        end
      end
    end
  end
end
