require 'rails_helper'
module Channels
  RSpec.describe Puml do
    let(:channel) {FactoryBot.create(:channel, 
      name: "TestChannel",
      uid: '3fa4fc38-1cb6-40ad-b91f-4aa7f3e44776',
    )}
    subject { Channels::Puml.new(channel: channel) }

    # check for instance methods
    describe "check if instance methods exists" do
      it { expect(subject).to be_kind_of(Channels::Puml) }
      it { expect(subject.respond_to? :call).to be_truthy }
    end

    describe "#new" do
      context "without :channel" do
        it "raises a KeyError" do
          expect {
            Creator.new(properties: {})
          }.to raise_error(KeyError)
        end
      end
    end

    describe "#call" do
      it "does nothing yet" do
        expect(subject.call).to eq("")
      end
    end
  end
end
