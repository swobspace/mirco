# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelStatisticProcessor, type: :model do
  let!(:server) do
    FactoryBot.create(:server,
                      name: 'testmirth',
                      uid: '3fa4fc38-1cb6-40ad-b91f-4aa7f3e44776')
  end
  let!(:channel) do
    FactoryBot.create(:channel,
                      server: server,
                      uid: '445cda00-c847-4198-a9be-eb0dc6b5946d')
  end
  let(:processor) { ChannelStatisticProcessor.new(channel_statistic) }

  describe "without existing statistic" do
    let(:channel_statistic) do
      FactoryBot.build(:channel_statistic,
        server_id: server.id,
        channel_id: channel.id,
        meta_data_id: 13,
        name: 'FRITZ',
        state: 'STARTED',
        status_type: 'DESTINATION_CONNECTOR',
        received: '1',
        sent: '2',
        error: '3',
        filtered: '4',
        queued: '5')
    end

    it { expect(processor.process).to be_truthy }

    it "creates ChannelStatistic" do
      expect {
        processor.process
      }.to change(ChannelStatistic, :count).by(1)
    end

    it "creates ChannelCounter" do
      expect {
        processor.process
      }.to change(ChannelCounter, :count).by(1)
    end
  end

  describe "with existing statistic" do
    let!(:channel_statistic) do
      FactoryBot.create(:channel_statistic,
        server_id: server.id,
        channel_id: channel.id,
        meta_data_id: 13,
        name: 'FRITZ',
        state: 'STARTED',
        status_type: 'DESTINATION_CONNECTOR',
        received: '1',
        sent: '2',
        error: '3',
        filtered: '4',
        queued: '5')
    end

    before(:each) do
      channel_statistic.name = 'HORST'
      channel_statistic.state = 'STOPPED'
      channel_statistic.received = 11
      channel_statistic.sent = 12
      channel_statistic.error = 13
      channel_statistic.filtered = 14
      channel_statistic.queued = 15
    end

    it { expect(processor.process).to be_truthy }

    it "creates ChannelStatistic" do
      expect {
        processor.process
      }.to change(ChannelStatistic, :count).by(0)
    end

    it "creates ChannelCounter" do
      expect {
        processor.process
      }.to change(ChannelCounter, :count).by(1)
    end

    it "updates channel_statistic and creates new channel_counter" do
      processor.process
      reload = channel_statistic.reload
      expect(reload.name).to eq('HORST')
      expect(reload.state).to eq('STOPPED')
      expect(reload.received).to eq(11)
      expect(reload.sent).to eq(12)
      expect(reload.error).to eq(13)
      expect(reload.filtered).to eq(14)
      expect(reload.queued).to eq(15)
    end
  end

  describe "with existing statistic, but no changes" do
    let!(:channel_statistic) do
      FactoryBot.create(:channel_statistic,
        server_id: server.id,
        channel_id: channel.id,
        meta_data_id: 13,
        name: 'FRITZ',
        state: 'STARTED',
        status_type: 'DESTINATION_CONNECTOR',
        received: '1',
        sent: '2',
        error: '3',
        filtered: '4',
        queued: '5',
        created_at: 1.day.before(Time.current),
        updated_at: 1.hour.before(Time.current),
     )
    end
    it "updates timestamp" do
      expect(channel_statistic.updated_at < 1.hour.before(Time.current)).to be_truthy
      processor.process
      channel_statistic.reload
      expect(channel_statistic.updated_at > 1.minute.before(Time.current)).to be_truthy
    end
  end

end
