# frozen_string_literal: true

# setup test environment
# - you can use any running mirth version 3.8 and above
# - set the the following variables in .env:
#     API_USER
#     API_PASSWORD
#     API_URL, i.e. https://localhost:8443/api
#     API_VERIFY_SSL true|false
#
# - if it doesn't work, test the mirth api with your browser and your credentials:
#   https://localhost:8443/api, use the login form on the right upper side
#
require 'rails_helper'
module System
  RSpec.describe FetchConfiguration do
    let!(:server) do
      FactoryBot.create(:server,
                        api_url: ENV['API_URL'],
                        api_user: ENV['API_USER'],
                        api_password: ENV['API_PASSWORD'],
                        api_verify_ssl: ENV['API_VERIFY_SSL'])
    end
    subject { System::FetchConfiguration.new(server: server) }

    # check for instance methods
    describe 'check if instance methods exists' do
      it { expect(subject.respond_to?(:call)).to be_truthy }
      it { expect(subject.call.respond_to?(:success?)).to be_truthy }
      it { expect(subject.call.respond_to?(:error_messages)).to be_truthy }
      it { expect(subject.call.respond_to?(:configuration)).to be_truthy }
    end

    describe '#call' do
      let!(:result) { subject.call }
      let(:doc)    { Nokogiri::XML(result.configuration) }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error_messages.present?).to be_falsey }
      it { expect(result.configuration).to be_present }
      it { expect(doc.xpath("serverConfiguration/channelGroups/channelGroup")).to be_present }
      it { expect(doc.xpath("serverConfiguration/channels/channel")).to be_present }
      it { expect(doc.xpath("serverConfiguration/serverSettings")).to be_present }
      it { expect(doc.xpath("serverConfiguration/globalScripts")).to be_present }
      it { expect(doc.xpath("serverConfiguration/pluginProperties")).to be_present }
      it { expect(doc.xpath("serverConfiguration/resourceProperties")).to be_present }
    end
  end
end
