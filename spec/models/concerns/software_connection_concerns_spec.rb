# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SoftwareConnectionConcerns, type: :model do
  let!(:host) { FactoryBot.create(:host, ipaddress: '192.0.2.81') }
  let(:source_url) { "tcp://0.0.0.0:1111" }
  let(:destination_url) { "tcp://1.2.3.4:1.2.3.4" }
  subject do 
    FactoryBot.create(:software_connection, 
      source_url: source_url,
      destination_url: destination_url
    )
  end

  describe '#src_url_host' do
    describe "with existing host" do
      let(:source_url) { 'tcp://192.0.2.81:5555' }
      it { expect(subject.src_url_host).to eq(host) }
      it { expect(subject.dst_url_host).to be_nil }
    end

    describe "with nonexisting host" do
      it { expect(subject.src_url_host).to be_nil }
      it { expect(subject.dst_url_host).to be_nil }
    end

    describe "with unparsable (aka nonip) host in url" do
      let(:source_url) { 'tcp://${maris}:5555' }
      it { expect(subject.src_url_host).to be_nil }
      it { expect(subject.dst_url_host).to be_nil }
    end
  end
end
