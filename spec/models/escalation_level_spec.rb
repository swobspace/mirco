require 'rails_helper'

RSpec.describe EscalationLevel, type: :model do
  let(:ng) { FactoryBot.create(:notification_group) }
  let(:cs) do
    FactoryBot.create(:channel_statistic,
      name: 'Some Statistics',
      error: 1,
      received: 123456,
      sent: 123450
    )
  end

  it { is_expected.to belong_to(:escalatable).optional }
  it { is_expected.to belong_to(:notification_group).optional }
  it { is_expected.to have_many(:escalation_times).dependent(:destroy) }
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

  describe "#to_s" do
    # let(:el) do
    #   FactoryBot.create(:escalation_level, attrib: 'last_message_received_at',
    #                                        escalatable: cs)
    # end
    let(:el2) do
      FactoryBot.create(:escalation_level, attrib: 'last_message_received_at',
                                           escalatable_type: 'ChannelStatistic',
                                           escalatable_id: 0)
    end
    it { expect(el2.to_s).to eq("ChannelStatistic (default) / last_message_received_at") }
  end

  describe "::check_for_escalation" do
    let!(:ts) { Time.current }

    describe "with unknown attribute" do
      it { expect(EscalationLevel.check_for_escalation(cs, 'notexistent').state).to eq(3) }
    end

    describe "attrib = last_message_received_at" do
      subject {EscalationLevel.check_for_escalation(cs, 'last_message_received_at')}

      describe "with no escalation levels" do
        it { expect(subject.state).to eq(-1) }
      end

      describe "with default escalation levels" do
        let!(:el_default) do
          FactoryBot.create(:escalation_level,
            escalatable_id: 0,
            escalatable_type: 'ChannelStatistic',
            notification_group_id: ng.id,
            attrib: 'last_message_received_at',
            min_critical: -1440,
            min_warning: -240,
            max_warning: 240,
            max_critical: 480
          )
        end

        it "CRITICAL if 2 days old" do
          cs.update(last_message_received_at: 2.days.before(ts))
          expect(subject.state).to eq(2)
        end

        it "WARNING less than 1 day old" do
          cs.update(last_message_received_at: 23.hours.before(ts))
          expect(subject.state).to eq(1)
        end

        it "OK less than 1h old" do
          cs.update(last_message_received_at: 50.minutes.before(ts))
          expect(subject.state).to eq(0)
        end

        it "WARNING 5h newer" do
          cs.update(last_message_received_at: 5.hours.after(ts))
          expect(subject.state).to eq(1)
        end

        it "CRITICAL 2d newer" do
          cs.update(last_message_received_at: 2.days.after(ts))
          expect(subject.state).to eq(2)
        end

        describe "and group escalation levels" do
          let!(:csg) { FactoryBot.create(:channel_statistic_group) }
          let!(:el_specific) do
            FactoryBot.create(:escalation_level,
              escalatable_id: csg.id,
              escalatable_type: 'ChannelStatisticGroup',
             notification_group_id: ng.id,
              attrib: 'last_message_received_at',
              min_warning: -480,
            )
          end
          before(:each) do
            csg.channel_statistics << cs
          end

          it "WARNING if 2 days old" do
            cs.update(last_message_received_at: 2.days.before(ts))
            expect(subject.state).to eq(1)
          end

          it "WARNING less than 1 day old" do
            cs.update(last_message_received_at: 23.hours.before(ts))
            expect(subject.state).to eq(1)
          end

          it "OK less than 1h old" do
            cs.update(last_message_received_at: 50.minutes.before(ts))
            expect(subject.state).to eq(0)
          end

          it "OK 5h newer" do
            cs.update(last_message_received_at: 5.hours.after(ts))
            expect(subject.state).to eq(0)
          end

          it "OK 2d newer" do
            cs.update(last_message_received_at: 2.days.after(ts))
            expect(subject.state).to eq(0)
          end
        end

        describe "and specific escalation levels" do
          let!(:el_specific) do
            FactoryBot.create(:escalation_level,
              escalatable_id: cs.id,
              escalatable_type: 'ChannelStatistic',
             notification_group_id: ng.id,
              attrib: 'last_message_received_at',
              min_warning: -480,
            )
          end

          it "WARNING if 2 days old" do
            cs.update(last_message_received_at: 2.days.before(ts))
            expect(subject.state).to eq(1)
          end

          it "WARNING less than 1 day old" do
            cs.update(last_message_received_at: 23.hours.before(ts))
            expect(subject.state).to eq(1)
          end

          it "OK less than 1h old" do
            cs.update(last_message_received_at: 50.minutes.before(ts))
            expect(subject.state).to eq(0)
          end

          it "OK 5h newer" do
            cs.update(last_message_received_at: 5.hours.after(ts))
            expect(subject.state).to eq(0)
          end

          it "OK 2d newer" do
            cs.update(last_message_received_at: 2.days.after(ts))
            expect(subject.state).to eq(0)
          end

          describe "with escalation times" do
            context "current" do
              let!(:et) do
                FactoryBot.create(:escalation_time,
                  escalation_level: el_specific,
                  weekdays: [Date.current.cwday]
                )
              end
              it "WARNING if 2 days old" do
                el_specific.reload
                expect(EscalationTime.count).to eq(1)
                expect(EscalationTime.current.count).to eq(1)
                cs.update(last_message_received_at: 2.days.before(ts))
                expect(subject.state).to eq(1)
              end
            end
          end
        end
      end
    end

    describe "attrib = queued" do
      subject {EscalationLevel.check_for_escalation(cs, 'queued')}

      describe "with no escalation levels" do
        it { expect(subject.state).to eq(-1) }
      end

      describe "with default escalation levels" do
        let!(:el_default) do
          FactoryBot.create(:escalation_level,
            escalatable_id: 0,
            escalatable_type: 'ChannelStatistic',
            notification_group_id: ng.id,
            attrib: 'queued',
            max_warning: 10,
            max_critical: 50
          )
        end

        it "OK if < 10 " do
          cs.update(queued: 5)
          expect(subject.state).to eq(0)
        end

        it "WARNING if < 50" do
          cs.update(queued: 25)
          expect(subject.state).to eq(1)
        end

        it "CRITICAL if > 50" do
          cs.update(queued: 81)
          expect(subject.state).to eq(2)
        end

        describe "and specific escalation levels" do
          let!(:el_specific) do
            FactoryBot.create(:escalation_level,
              escalatable_id: cs.id,
              escalatable_type: 'ChannelStatistic',
              notification_group_id: ng.id,
              attrib: 'queued',
              max_warning: 5
            )
          end

          it "OK if < 5 " do
            cs.update(queued: 2)
            expect(subject.state).to eq(0)
          end

          it "WARNING if = 30 " do
            cs.update(queued: 30)
            expect(subject.state).to eq(1)
          end

          it "WARNING if =81 " do
            cs.update(queued: 81)
            expect(subject.state).to eq(1)
          end
        end
      end
    end
  end

  describe "::active_escalation_levels" do
    let!(:csg) do
      FactoryBot.create(:channel_statistic_group,
        channel_statistic_ids: [cs.id]
      )
    end
    let!(:queued_specific) do
      FactoryBot.create(:escalation_level,
        escalatable_id: cs.id,
        escalatable_type: 'ChannelStatistic',
        attrib: 'queued',
      )
    end
    
    let!(:queued_group) do
      FactoryBot.create(:escalation_level,
        escalatable_id: cs.id,
        escalatable_type: 'ChannelStatisticGroup',
        attrib: 'queued',
      )
    end
    let!(:sent_group) do
      FactoryBot.create(:escalation_level,
        escalatable_id: csg.id,
        escalatable_type: 'ChannelStatisticGroup',
        attrib: 'last_message_sent_at',
      )
    end
    let!(:sent_default) do
      FactoryBot.create(:escalation_level,
        escalatable_id: 0,
        escalatable_type: 'ChannelStatistic',
        attrib: 'last_message_sent_at',
      )
    end
    let!(:queued_default) do
      FactoryBot.create(:escalation_level,
        escalatable_id: 0,
        escalatable_type: 'ChannelStatistic',
        attrib: 'queued',
      )
    end
    let!(:received_default) do
      FactoryBot.create(:escalation_level,
        escalatable_id: 0,
        escalatable_type: 'ChannelStatistic',
        attrib: 'last_message_received_at',
      )
    end
    
    it { expect(EscalationLevel.active_escalation_levels(cs)).to contain_exactly(
                received_default, sent_group, queued_specific) }
    
    
  end

end
