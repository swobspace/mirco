# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerDecorator do
  let(:time_now) { Time.current }
  let(:srv) { server.decorate }

  describe 'with timestamps set' do
    let(:server) do
      FactoryBot.create(:server,
                        last_channel_update: time_now,
                        last_check: time_now,
                        last_check_ok: time_now)
    end
    it { expect(srv.last_channel_update).to eq(server.last_channel_update.localtime.to_formatted_s(:db)) }
    it { expect(srv.last_check).to eq(server.last_check.localtime.to_formatted_s(:db)) }
    it { expect(srv.last_check_ok).to eq(server.last_check_ok.localtime.to_formatted_s(:db)) }
  end

  describe 'with empty timestamps' do
    let(:server) { FactoryBot.create(:server) }
    it { expect(srv.last_channel_update).to be_nil }
    it { expect(srv.last_check).to be_nil }
    it { expect(srv.last_check_ok).to be_nil }
  end
end
