# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channels::FetchStatisticsJob, type: :job do
  before(:all) { ActiveJob::Base.queue_adapter = :delayed_job }

  describe '#perform_later' do
    it 'fetch channel statistics' do
      expect do
        Channels::FetchStatisticsJob.perform_later
      end.to change(Delayed::Job, :count).by(1)
    end
  end

  describe 'scheduling' do
    before { Delayed::Job.delete_all }

    let(:cron)    { '5 1 * * *' }
    let(:job)     { Channels::FetchStatisticsJob.set(cron: cron).perform_later }
    let(:delayed_job) { Delayed::Job.first }
    let(:worker)  { Delayed::Worker.new }
    let(:now)     { Delayed::Job.db_time_now }
    let(:next_run) do
      run = now.hour * 60 + now.min >= 65 ? now + 1.day : now
      Time.local(run.year, run.month, run.day, 1, 5)
    end

    context 'with cron' do
      it 'sets run_at on enqueue' do
        expect { job }.to change { Delayed::Job.count }.by(1)
        expect(delayed_job.run_at).to eq(next_run)
        expect(delayed_job.cron).to eq(cron)
      end

      it 'schedules a new job after success' do
        job
        delayed_job.update_column(:run_at, now)
        delayed_job.reload

        worker.work_off

        expect(Delayed::Job.count).to eq(1)
        j = Delayed::Job.first
        expect(j.id).to eq(delayed_job.id)
        expect(j.cron).to eq(delayed_job.cron)
        expect(j.run_at).to eq(next_run)
        expect(j.attempts).to eq(1)
        expect(j.last_error).to eq(nil)
        expect(j.created_at).to eq(delayed_job.created_at)
      end
    end

    context 'without cron' do
      let(:job) { Channels::FetchStatisticsJob.perform_later }

      it 'sets run_at but not cron on enqueue' do
        expect { job }.to change { Delayed::Job.count }.by(1)
        expect(delayed_job.run_at).to be <= now
        expect(delayed_job.cron).to be_nil
      end
    end
  end
end
