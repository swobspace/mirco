# frozen_string_literal: true

require 'rails_helper'
module Statistics
  RSpec.describe Creator do
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
    let(:attributes) do
      {
        'channel_uid' => '445cda00-c847-4198-a9be-eb0dc6b5946d',
        'meta_data_id' => 13,
        'name' => 'FRITZ',
        'state' => 'STARTED',
        'status_type' => 'DESTINATION_CONNECTOR',
        'received' => '1',
        'sent' => '2',
        'error' => '3',
        'filtered' => '4',
        'queued' => '5'
      }
    end

    subject { Statistics::Creator.new(server: server, attributes: attributes) }

    # check for instance methods
    describe 'check if instance methods exists' do
      it { expect(subject).to be_kind_of(Statistics::Creator) }
      it { expect(subject.respond_to?(:save)).to be_truthy }
    end

    describe '#new' do
      context 'without :server' do
        it 'raises a KeyError' do
          expect do
            Creator.new(attributes: {})
          end.to raise_error(KeyError)
        end
      end

      context 'without :attributes' do
        it 'raises a KeyError' do
          expect do
            Creator.new(server: server)
          end.to raise_error(KeyError)
        end
      end

      context "without :uid or attributes['id']" do
        it 'raises an RuntimeError' do
          expect do
            Creator.new(server: server, attributes: {})
          end.to raise_error(RuntimeError)
        end
      end
    end

    describe '#save' do
      context 'new channel statistic' do
        let(:statistic) do
          subject.save
          ChannelStatistic.first
        end
        it 'create a new channel statistic' do
          expect do
            subject.save
          end.to change(ChannelStatistic, :count).by(1)
        end

        it { expect(statistic.name).to eq('FRITZ') }
        it { expect(statistic.state).to eq('STARTED') }
        it { expect(statistic.status_type).to eq('DESTINATION_CONNECTOR') }
        it { expect(statistic.received).to eq(1) }
        it { expect(statistic.sent).to eq(2) }
        it { expect(statistic.error).to eq(3) }
        it { expect(statistic.filtered).to eq(4) }
        it { expect(statistic.queued).to eq(5) }
      end

      context 'existing channel statistic' do
        let!(:statistik) do
          FactoryBot.create(:channel_statistic,
                            server_id: server.id,
                            server_uid: server.uid,
                            channel_id: channel.id,
                            channel_uid: channel.uid,
                            'name' => 'HORST',
                            'state' => 'STOPPED',
                            'status_type' => 'UNKNOWN',
                            'meta_data_id' => 13,
                            'received' => '11',
                            'sent' => '22',
                            'error' => '33',
                            'filtered' => '44',
                            'queued' => '55',
                            updated_at: 5.minutes.before(Time.current))
        end

        let(:statistic) do
          subject.save
          ChannelStatistic.first
        end
        it 'update existing channel statistic' do
          expect do
            subject.save
          end.to change(ChannelStatistic, :count).by(0)
        end

        it { expect(statistic.name).to eq('FRITZ') }
        it { expect(statistic.state).to eq('STARTED') }
        it { expect(statistic.status_type).to eq('DESTINATION_CONNECTOR') }
        it { expect(statistic.received).to eq(1) }
        it { expect(statistic.sent).to eq(2) }
        it { expect(statistic.error).to eq(3) }
        it { expect(statistic.filtered).to eq(4) }
        it { expect(statistic.queued).to eq(5) }
        it { expect(statistic.updated_at).to be >= 1.minute.before(Time.current) }
      end

      context 'nonexistent channel' do
        subject { Statistics::Creator.new(server: server, attributes: attributes, create_channel: true) }
        let(:attributes) do
          {
            'channel_uid' => '72c41ac8-a60c-4ca3-8490-6cd285871ac3',
            'meta_data_id' => nil,
            'name' => 'Dummy',
            'state' => 'STOPPED',
            'status_type' => 'DESTINATION',
            'received' => '6',
            'sent' => '7',
            'error' => '8',
            'filtered' => '9',
            'queued' => '10'
          }
        end

        let(:statistic) do
          subject.save
          ChannelStatistic.first
        end

        it 'create a new channel statistic' do
          expect do
            subject.save
          end.to change(ChannelStatistic, :count).by(1)
        end
        it 'create a new channel statistic' do
          expect do
            subject.save
          end.to change(Channel, :count).by(1)
        end

        it { expect(statistic.meta_data_id).to be_nil }
        it { expect(statistic.name).to eq('Dummy') }
        it { expect(statistic.state).to eq('STOPPED') }
        it { expect(statistic.status_type).to eq('DESTINATION') }
        it { expect(statistic.received).to eq(6) }
        it { expect(statistic.sent).to eq(7) }
        it { expect(statistic.error).to eq(8) }
        it { expect(statistic.filtered).to eq(9) }
        it { expect(statistic.queued).to eq(10) }
      end
    end
  end
end
