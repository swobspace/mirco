require 'rails_helper'

RSpec.describe Servers::FetchConfigurationJob, type: :job do
  let(:server) { FactoryBot.create(:server) }
  describe '#perform_later' do
    it 'matches with enqueued job without args' do
      expect do
        Servers::FetchConfigurationJob.perform_later
      end.to have_enqueued_job(Servers::FetchConfigurationJob)
    end

    it 'matches with enqueued job with server' do
      expect do
        Servers::FetchConfigurationJob.perform_later(server: server)
      end.to have_enqueued_job(Servers::FetchConfigurationJob).with(server: server)
    end
  end

end
