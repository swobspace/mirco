require 'rails_helper'

RSpec.describe ServerConfiguration, type: :model do
  let(:server) { FactoryBot.create(:server, name: 'xyzmirth') }
  let(:config) do
    FactoryBot.create(:server_configuration, 
                      server: server,
                      created_at: '2021-01-01 07:08:00')
  end

  it { is_expected.to belong_to(:server) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:server_configuration)
    g = FactoryBot.create(:server_configuration)
    expect(f).to be_valid
    expect(g).to be_valid
  end

  describe "#to_s" do
    it { expect(config.to_s).to eq("server-config-xyzmirth-2021-01-01_07:08:00") }
  end

end
