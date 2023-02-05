# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerZip, type: :model do
  let(:properties) do
    YAML.load_file(
      Rails.root.join('spec', 'fixtures', 'files', 'channel_11.yaml')
    )
  end
  let(:server)  { FactoryBot.create(:server) }
  let!(:channel) do
    FactoryBot.create(:channel,
      properties: properties,
      server: server
    )
  end

  let!(:zipfile) {
    zipfile = ServerZip.new(server); zipfile.pack; zipfile
  }
  let!(:zipfile_list) {
    ::Zip::File.open(zipfile.tmpfile).entries.map {|z| z.name.force_encoding("utf-8")}
  }
  describe "creating Zip from Server" do
    after(:each) { zipfile.destroy }

    it { expect(File.readable?(zipfile.tmpfile)).to be_truthy }
    it { expect(File.size(zipfile.tmpfile)).to be > 100 }
    it "should have mimetype application/zip with charset=binary" do
      mimetype = `file -ib #{zipfile.tmpfile}`.gsub(/\n/,"")
      expect(mimetype).to match(/application\/zip; charset=binary/)
    end

    it { expect(zipfile_list).to contain_exactly(
                                   server.name,
                                   "images/#{server.name}.svg",
                                   "pages/#{channel.name}.adoc",
                                   "images/#{channel.name}.svg",
         )
       }
    # it { puts zipfile_list }
    # it { puts zipfile.tmpfile.to_s }
    # it { puts server.channels.size }

  end
end
