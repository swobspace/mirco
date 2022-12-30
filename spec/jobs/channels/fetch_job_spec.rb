# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channels::FetchJob, type: :job do
  let(:server) { FactoryBot.create(:server) }
  describe '#perform_later' do
    it 'matches with enqueued job without args' do
      expect do
        Channels::FetchJob.perform_later
      end.to have_enqueued_job(Channels::FetchJob)
    end

    it 'matches with enqueued job with server' do
      expect do
        Channels::FetchJob.perform_later(server: server)
      end.to have_enqueued_job(Channels::FetchJob).with(server: server)
    end
  end
end
