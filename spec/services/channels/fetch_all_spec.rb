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
module Channels
  RSpec.describe FetchAll do
    let!(:server) { FactoryBot.create(:server,
      api_url: ENV['API_URL'],
      api_user: ENV['API_USER'],
      api_password: ENV['API_PASSWORD'],
      api_verify_ssl: ENV['API_VERIFY_SSL']
    )}
    subject { Channels::FetchAll.new(server: server) }

    # check for instance methods
    describe "check if instance methods exists" do
      it { expect(subject.respond_to? :call).to be_truthy}
      it { expect(subject.call.respond_to? :success?).to be_truthy }
      it { expect(subject.call.respond_to? :error_messages).to be_truthy }
    end

    describe "#call" do
     let(:result) { subject.call }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error_messages.present?).to be_falsey }

      it "assigns channels to server" do
        expect {
          subject.call
        }.to change(Channel, :count).by_at_least(1)
      end

      it "DEBUG: some channels" do
        puts "\n\n"
        puts result.error_messages.join("\n")
        puts server.channels.map{|c| c.uid}.join("\n")
      end
    end

  end
end
