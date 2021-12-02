require 'rails_helper'

RSpec.describe Mirco::ServerDiagram, type: :model do
  let(:properties) do
    YAML.load_file(
      File.join(Rails.root, 'spec', 'fixtures', 'files', 'channel_properties.yaml')
    )
  end

  let(:server) { FactoryBot.create(:server) }
  let(:channel) { FactoryBot.create(:channel, server: server, properties: properties) }
  subject { Mirco::ServerDiagram.new(server) }

  it {
    expect(subject.path).to eq(
      Rails.root.to_s + "/tmp/cache/servers/server_#{server.id}"
    )
  }
  it {
    expect(subject.filename(:puml)).to eq(
      Rails.root.to_s + "/tmp/cache/servers/server_#{server.id}.puml"
    )
  }
  it { expect(subject.basename).to eq("server_#{server.id}") }

  describe '#mk_cachedir' do
    it 'creates cache directory' do
      subject.mk_cachedir
      expect(File.exist?(subject.cachedir)).to be_truthy
    end
  end

  describe '#create' do
    after(:each) do
      subject.delete
    end

    it 'creates puml file' do
      subject.create(:svg)

      puts subject.filename(:puml)
      expect(File.exist?(subject.filename(:puml))).to be_truthy
      expect(File.exist?(subject.filename(:svg))).to be_truthy
    end
  end
end
