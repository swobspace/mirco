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
  RSpec.describe FetchParams do
    let!(:server) { FactoryBot.create(:server,
      api_url: ENV['API_URL'],
      api_user: ENV['API_USER'],
      api_password: ENV['API_PASSWORD'],
      api_verify_ssl: ENV['API_VERIFY_SSL']
    )}
    subject { System::FetchParams.new(server: server) }

    # check for instance methods
    describe "check if instance methods exists" do
      it { expect(subject.respond_to? :call).to be_truthy}
      it { expect(subject.call.respond_to? :success?).to be_truthy }
      it { expect(subject.call.respond_to? :error_messages).to be_truthy }
      it { expect(subject.call.respond_to? :params).to be_truthy }
    end

    describe "#call" do
     let(:result) { subject.call }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error_messages.present?).to be_falsey }
      it { expect(result.params).to be_present }
      it { expect(result.params[:system_info]).to be_present }
      it { expect(result.params[:server_settings]).to be_present }
      it { expect(result.params[:server_uid]).to be_present }
      it { expect(result.params[:server_jvm]).to be_present }
      it { expect(result.params[:server_version]).to be_present }
      it "show :system_info" do
        printf "\n-- :system_info --\n"
        pp result.params[:system_info]
        printf "\n-- :server_settings --\n"
        pp result.params[:server_settings]
        printf "\n-- id, version, jvm --\n"
        puts "server_uid: #{result.params[:server_uid]}"
        puts "server_version: #{result.params[:server_version]}"
        puts "server_jvm: #{result.params[:server_jvm]}"
        printf "\n"
      end
    end



  end
end
