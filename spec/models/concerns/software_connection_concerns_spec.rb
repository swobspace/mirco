# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SoftwareConnectionConcerns, type: :model do
  let!(:host) { FactoryBot.create(:host, ipaddress: '192.0.2.81') }
  let(:source_url) { "tcp://0.0.0.0:1111" }
  let(:destination_url) { "tcp://1.2.3.4:1.2.3.4" }
  let(:channel) { FactoryBot.create(:channel, state: 'STARTED') }
  let(:conn) do 
    FactoryBot.create(:software_connection, 
      source_url: source_url,
      destination_url: destination_url,
      channel_ids: [channel.id]
    )
  end

  describe '#src_url_host' do
    describe "with existing host" do
      let(:source_url) { 'tcp://192.0.2.81:5555' }
      it { expect(conn.src_url_host).to eq(host) }
      it { expect(conn.dst_url_host).to be_nil }
    end

    describe "with nonexisting host" do
      it { expect(conn.src_url_host).to be_nil }
      it { expect(conn.dst_url_host).to be_nil }
    end

    describe "with unparsable (aka nonip) host in url" do
      let(:source_url) { 'tcp://${maris}:5555' }
      it { expect(conn.src_url_host).to be_nil }
      it { expect(conn.dst_url_host).to be_nil }
    end
  end

  describe "#disabled_channels?" do
    describe "with enabled channel" do
      it { expect(conn.disabled_channels?).to be_falsey }
    end
    describe "with disabled channel" do
      let(:properties) do
        { exportData: { "metadata" => { "enabled" => "false" } } }
      end
      let!(:channel) { FactoryBot.create(:channel, properties: properties) }
      it { expect(conn.disabled_channels?).to be_truthy }
    end
  end
end
