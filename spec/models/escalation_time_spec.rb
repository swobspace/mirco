require 'rails_helper'

RSpec.describe EscalationTime, type: :model do
  let(:el) { FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')}
  let(:escalation_time) do
    FactoryBot.create(:escalation_time,
      escalation_level: el,
      start_time: '08:00',
      end_time: '16:00',
      weekdays: [1,2,3,5]
    )
  end
  it { is_expected.to belong_to(:escalation_level).optional }
  # it { is_expected.to validate_presence_of(:weekdays) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:escalation_time, escalation_level: el)
    g = FactoryBot.create(:escalation_time, escalation_level: el)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  it "weekdays = [] empty array is not allowed" do
    f = EscalationTime.new(escalation_level_id: el.id, weekdays: [nil, 18, 34])
    expect {
      f.save
    }.to change(EscalationTime, :count).by(0)
  end

  it "default time frame" do
    f = FactoryBot.create(:escalation_time, escalation_level: el)
    expect(f.start_time).to eq '00:00:00'
    expect(f.end_time).to eq '23:59:59'
  end

  describe "#to_s" do
    it { expect(escalation_time.to_s).to match('08:00-16:00 Mo,Di,Mi,Fr') }
  end

  describe "#current" do
    let!(:other_day) do
      FactoryBot.create(:escalation_time,
        escalation_level: el,
        start_time: '08:00',
        end_time: '16:00',
        weekdays: [1.day.after(Date.current).cwday]
      )
    end
    let!(:wrong_hour) do
      FactoryBot.create(:escalation_time,
        escalation_level: el,
        start_time: 1.hour.after(Time.now).to_fs(:time),
        end_time: 2.hours.after(Time.now).to_fs(:time),
        weekdays: [Date.current.cwday]
      )
    end
    let!(:matching) do
      FactoryBot.create(:escalation_time,
        escalation_level: el,
        start_time: 30.minutes.before(Time.current).to_fs(:time),
        end_time: 30.minutes.after(Time.current).to_fs(:time),
        weekdays: [Date.current.cwday]
      )
    end
    let!(:allday) do
      FactoryBot.create(:escalation_time,
        escalation_level: el,
        start_time: '00:00',
        end_time: '23:59',
        weekdays: [Date.current.cwday]
      )
    end
    it "finds 1 matching escalation time" do
      puts matching.to_yaml
      expect(EscalationTime.current).to contain_exactly(matching, allday)
    end
  end
end
