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
module Statistics
  RSpec.describe FetchAll do
    let!(:server) do
      FactoryBot.create(:server,
                        api_url: ENV['API_URL'],
                        api_user: ENV['API_USER'],
                        api_password: ENV['API_PASSWORD'],
                        api_verify_ssl: ENV['API_VERIFY_SSL'],
                        uid: ENV['SERVER_UID'])
    end
    subject { Statistics::FetchAll.new(server: server, create_channel: true) }

    # check for instance methods
    describe 'check if instance methods exists' do
      it { expect(subject.respond_to?(:call)).to be_truthy }
      it { expect(subject.call.respond_to?(:success?)).to be_truthy }
      it { expect(subject.call.respond_to?(:error_messages)).to be_truthy }
    end

    describe '#call' do
      let(:result) { subject.call }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error_messages.present?).to be_falsey }

      it 'creates channel statistics' do
        expect do
          subject.call
        end.to change(ChannelStatistic, :count).by_at_least(1)
      end
      it 'changes server.last_check*' do
        result
        server.reload
        expect(server.last_check).to be >= 1.minutes.ago
        expect(server.last_check_ok).to be >= 1.minutes.ago
      end

      it 'creates statistics for channel, source and destinations' do
        result
        expect(ChannelStatistic.where(meta_data_id: nil).any?).to be_truthy
        expect(ChannelStatistic.where(meta_data_id: 0).any?).to be_falsey
        expect(ChannelStatistic.where(meta_data_id: 1).any?).to be_truthy
      end
    end
  end
end
