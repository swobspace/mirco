# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Server, type: :model do
  let(:server) do 
    FactoryBot.create(:server, 
      name: 'xyzmirth',
      api_url: 'https://11.22.33.55:8443/api'
    ) 
  end
  it { is_expected.to belong_to(:location).optional }
  it { is_expected.to have_many(:alerts).dependent(:destroy) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:channels).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:channel_statistics).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:channel_counters).dependent(:destroy) }
  it { is_expected.to have_many(:server_configurations).dependent(:restrict_with_error) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:server)
    g = FactoryBot.create(:server)
    expect(f).to be_valid
    expect(g).to be_valid
    expect(f).to validate_uniqueness_of(:name).case_insensitive
    expect(f).to validate_uniqueness_of(:uid).case_insensitive
  end

  describe "#to_s" do
    it { expect(server.to_s).to match('xyzmirth') }
  end

  describe "#full_name" do
    it { expect(server.fullname).to match('xyzmirth') }
  end

  describe "#host" do
    it { expect(server.host).to eq('11.22.33.55') }
  end

end
