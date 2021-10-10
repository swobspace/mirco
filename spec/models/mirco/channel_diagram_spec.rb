require 'rails_helper'

RSpec.describe Mirco::ChannelDiagram, type: :model do
  let(:properties) { YAML.load_file(
    File.join(Rails.root, 'spec', 'fixtures', 'files', 'channel_properties.yaml')
  )}

  let(:channel) { FactoryBot.create(:channel, properties: properties) }
  subject { Mirco::ChannelDiagram.new(channel) }

  it { expect(subject.path).to eq(
         Rails.root.to_s + "/tmp/cache/channels/channel_#{channel.id}") }
  it { expect(subject.filename(:puml)).to eq(
         Rails.root.to_s + "/tmp/cache/channels/channel_#{channel.id}.puml") }
  it { expect(subject.basename).to eq("channel_#{channel.id}") }

  describe "#mk_cachedir" do
    it "creates cache directory" do
      subject.mk_cachedir
      expect(File.exists? subject.cachedir).to be_truthy
    end
  end

  describe "#create" do
    after(:each) do
      subject.delete
    end

    it "creates puml file" do
      subject.create(:svg)

      puts subject.filename(:puml)
      expect(File.exists? subject.filename(:puml)).to be_truthy
      expect(File.exists? subject.filename(:svg)).to be_truthy
    end
  end

 
end

