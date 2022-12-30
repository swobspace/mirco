# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channels::FetchStatisticsJob, type: :job do
  let(:server) { FactoryBot.create(:server) }
  describe '#perform_later' do
    it 'matches with enqueued job without arg' do
      expect do
        Channels::FetchStatisticsJob.perform_later
      end.to have_enqueued_job(Channels::FetchStatisticsJob)
    end

    it 'matches with enqueued job with server' do
      expect do
        Channels::FetchStatisticsJob.perform_later(server: server)
      end.to have_enqueued_job(Channels::FetchStatisticsJob).with(server: server)
    end
  end
end
