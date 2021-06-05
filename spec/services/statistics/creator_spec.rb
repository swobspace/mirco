require 'rails_helper'
module Statistics
  RSpec.describe Creator do
    let!(:server) {FactoryBot.create(:server, 
      name: "testmirth",
      uid: '3fa4fc38-1cb6-40ad-b91f-4aa7f3e44776',
    )}
    let!(:channel) { FactoryBot.create(:channel,
      server: server,
      uid: '445cda00-c847-4198-a9be-eb0dc6b5946d',
    )}
    let(:attributes) {{
      'serverId' => '3fa4fc38-1cb6-40ad-b91f-4aa7f3e44776',
      'channelId' => '445cda00-c847-4198-a9be-eb0dc6b5946d',
      'received' => '1',
      'sent' => '2',
      'error' => '3',
      'filtered' => '4',
      'queued' => '5',
    }}

    subject { Statistics::Creator.new(server: server, attributes: attributes) }

    # check for instance methods
    describe "check if instance methods exists" do
      it { expect(subject).to be_kind_of(Statistics::Creator) }
      it { expect(subject.respond_to? :save).to be_truthy }
    end

    describe "#new" do
      context "without :server" do
        it "raises a KeyError" do
          expect {
            Creator.new(attributes: {})
          }.to raise_error(KeyError)
        end
      end

      context "without :attributes" do
        it "raises a KeyError" do
          expect {
            Creator.new(server: server)
          }.to raise_error(KeyError)
        end
      end

      context "without :uid or attributes['id']" do
        it "raises an RuntimeError" do
          expect {
            Creator.new(server: server, attributes: {})
          }.to raise_error(RuntimeError)
        end
      end
    end

    describe "#save" do
      context "new channel statistic" do
        let(:statistic) { subject.save; ChannelStatistic.first }
        it "create a new channel statistic" do
          expect {
            result = subject.save
            
          }.to change(ChannelStatistic, :count).by(1)
        end

        it { expect(statistic.received).to eq(1) }
        it { expect(statistic.sent).to eq(2) }
        it { expect(statistic.error).to eq(3) }
        it { expect(statistic.filtered).to eq(4) }
        it { expect(statistic.queued).to eq(5) }
      end

      context "nonexistent channel" do
        subject { Statistics::Creator.new(server: server, attributes: attributes, create_channel: true ) }
        let(:attributes) {{
          'serverId' => '3fa4fc38-1cb6-40ad-b91f-4aa7f3e44776',
          'channelId' => '72c41ac8-a60c-4ca3-8490-6cd285871ac3',
          'received' => '1',
          'sent' => '2',
          'error' => '3',
          'filtered' => '4',
          'queued' => '5',
        }}

        let(:statistic) { subject.save; ChannelStatistic.first }

        it "create a new channel statistic" do
          expect {
            result = subject.save
            
          }.to change(ChannelStatistic, :count).by(1)
        end
        it "create a new channel statistic" do
          expect {
            result = subject.save
            
          }.to change(Channel, :count).by(1)
        end

        it { expect(statistic.received).to eq(1) }
        it { expect(statistic.sent).to eq(2) }
        it { expect(statistic.error).to eq(3) }
        it { expect(statistic.filtered).to eq(4) }
        it { expect(statistic.queued).to eq(5) }
      end
    end
  end
end
