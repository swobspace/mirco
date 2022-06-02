require 'rails_helper'

RSpec.describe SoftwareConnection, type: :model do
  let(:location) { FactoryBot.create(:location, lid: 'LLX') }
  let(:srcconn) { FactoryBot.create(:interface_connector) }
  let(:dstconn) { FactoryBot.create(:interface_connector) }
  let(:software_connection) do
    FactoryBot.create(:software_connection, 
      location: location,
      source_connector: srcconn,
      destination_connector: dstconn,
      source_url: 'tcp://192.0.2.1:5555',
      destination_url: 'tcp://192.0.2.20:12345',
    )
  end
  it { is_expected.to belong_to(:source_connector).class_name('InterfaceConnector').optional }
  it { is_expected.to belong_to(:destination_connector).class_name('InterfaceConnector').optional }
  it { is_expected.to belong_to(:location) }
  it { is_expected.to validate_presence_of(:source_url) }
  it { is_expected.to validate_presence_of(:destination_url) }
  it { is_expected.to validate_presence_of(:location_id) }
  it { is_expected.to have_rich_text(:description) }

  it 'should get plain factory working' do
    f = FactoryBot.create(:software_connection)
    g = FactoryBot.create(:software_connection)
    expect(f).to be_valid
    expect(g).to be_valid
    is_expected.to validate_uniqueness_of(:source_url).scoped_to([:location_id, :destination_url])
  end

  describe "#to_s" do
    it { expect(software_connection.to_s).to match("#{location.lid}: #{srcconn} -> #{dstconn}") }
  end


end
