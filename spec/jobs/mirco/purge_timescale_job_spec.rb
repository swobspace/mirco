require 'rails_helper'

module Mirco
  RSpec.describe PurgeTimescaleJob, type: :job do
    describe '#perform_later' do
      it 'matches with enqueued job without args' do
        expect do
          Mirco::PurgeTimescaleJob.perform_later
        end.to have_enqueued_job(Mirco::PurgeTimescaleJob)
      end
    end
  end
end
