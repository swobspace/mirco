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
RSpec.describe BackupServer, type: :model do
  let!(:server) do
    FactoryBot.create(:server,
                      api_url: ENV['API_URL'],
                      api_user: ENV['API_USER'],
                      api_password: ENV['API_PASSWORD'],
                      api_verify_ssl: ENV['API_VERIFY_SSL'],
                      uid: ENV['SERVER_UID'])
  end

  let(:backup) { BackupServer.new(server) }

  describe 'check if instance methods exists' do
    it { expect(backup.respond_to?(:create)).to be_truthy }
  end

  describe "#create" do
    it "creates a server_configuration record" do
      expect do
        backup.create
      end.to change(ServerConfiguration, :count).by(1)
    end

    it "attaches an xmlfile to server_configuration" do
      backup.create
      config = ServerConfiguration.last
      doc = Nokogiri::XML(config.xmlfile.download)
      expect(doc.xpath("serverConfiguration/channelGroups/channelGroup")).to be_present
      expect(doc.xpath("serverConfiguration/channels/channel")).to be_present
      expect(doc.xpath("serverConfiguration/serverSettings")).to be_present
      expect(doc.xpath("serverConfiguration/globalScripts")).to be_present
      expect(doc.xpath("serverConfiguration/pluginProperties")).to be_present
      expect(doc.xpath("serverConfiguration/resourceProperties")).to be_present
    end

    it "set some attributes from server_configuration_params" do
      backup.create(comment: "Just a comment for backup")
      expect(ServerConfiguration.last.comment).to eq("Just a comment for backup")
    end
  end

end
