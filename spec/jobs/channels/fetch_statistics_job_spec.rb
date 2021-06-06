require 'rails_helper'

RSpec.describe Channels::FetchStatisticsJob, type: :job do
  describe "#perform_later" do
    it "fetch channel statistics" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        Channels::FetchStatisticsJob.perform_later()
      }.to have_enqueued_job
    end
  end
end
