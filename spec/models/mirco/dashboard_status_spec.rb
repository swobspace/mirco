# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mirco::DashboardStatus, type: :model do
  let(:xmlfile) do
    Rails.root.join('spec', 'fixtures', 'files', 'channel_statuses.xml')
  end

  describe '::parse_xml' do
    let!(:xml) { File.open(xmlfile, &:read) }
    let(:statuses) { Mirco::DashboardStatus.parse_xml(xml) }

    it { expect(statuses.count).to eq(10) }
    it { expect(statuses.select { |x| x.status_type == 'CHANNEL' }.count).to eq(3) }
    it { expect(statuses.select { |x| x.status_type == 'SOURCE_CONNECTOR' }.count).to eq(3) }
    it { expect(statuses.select { |x| x.status_type == 'DESTINATION_CONNECTOR' }.count).to eq(4) }
    it { expect(statuses[0].status_type).to eq('CHANNEL') }
    it { expect(statuses[3].status_type).to eq('CHANNEL') }
    it { expect(statuses[6].status_type).to eq('CHANNEL') }
    it { expect(statuses[1].status_type).to eq('SOURCE_CONNECTOR') }
    it { expect(statuses[4].status_type).to eq('SOURCE_CONNECTOR') }
    it { expect(statuses[7].status_type).to eq('SOURCE_CONNECTOR') }
    it { expect(statuses[0].meta_data_id).to be_nil }
    it { expect(statuses[1].meta_data_id).to eq(0) }
    it { expect(statuses[3].meta_data_id).to be_nil }
    it { expect(statuses[4].meta_data_id).to eq(0) }
    it { expect(statuses[7].meta_data_id).to eq(0) }
    it { expect(statuses[0].received).to eq(117_112) }
    it { expect(statuses[0].filtered).to eq(0) }
    it { expect(statuses[0].error).to eq(0) }
    it { expect(statuses[0].queued).to eq(0) }
    it { expect(statuses[0].sent).to eq(117_112) }
    it { expect(statuses[8].name).to eq('DMI/Pegasos') }
    it { expect(statuses[8].meta_data_id).to eq(1) }
    it { expect(statuses[8].received).to eq(154_998) }
    it { expect(statuses[8].filtered).to eq(0) }
    it { expect(statuses[8].error).to eq(0) }
    it { expect(statuses[8].queued).to eq(0) }
    it { expect(statuses[8].sent).to eq(154_979) }

    it 'set hash attributes' do
      expect(statuses[8].attributes).to include(
        'name' => 'DMI/Pegasos',
        'state' => 'STARTED',
        'status_type' => 'DESTINATION_CONNECTOR',
        'channel_uid' => 'd1dd8a9f-5cf1-4653-96ef-55c31dac6fae',
        'meta_data_id' => 1,
        'received' => 154_998,
        'filtered' => 0,
        'error' => 0,
        'sent' => 154_979,
        'queued' => 0
      )
    end
  end
end
