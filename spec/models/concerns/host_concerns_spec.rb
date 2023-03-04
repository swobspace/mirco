# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HostConcerns, type: :model do
  describe '#ping?' do
    context 'with reachable host' do
      let(:host) { FactoryBot.create(:host, ipaddress: '127.0.0.1') }
      it { expect(host.up?).to be_truthy }
    end
    context 'with unreachable host' do
      let(:host) { FactoryBot.create(:host, ipaddress: '1.2.3.4') }
      it { expect(host.up?).to be_falsey }
    end
  end
end
