require 'rails_helper'

RSpec.describe Servers::FetchPropertiesJob, type: :job do
  let(:server) { FactoryBot.create(:server) }
  describe '#perform_later' do
    it 'matches with enqueued job without args' do
      expect do
        Servers::FetchPropertiesJob.perform_later
      end.to have_enqueued_job(Servers::FetchPropertiesJob)
    end

    it 'matches with enqueued job with server' do
      expect do
        Servers::FetchPropertiesJob.perform_later(server: server)
      end.to have_enqueued_job(Servers::FetchPropertiesJob).with(server: server)
    end
  end

end
