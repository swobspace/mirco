require 'rails_helper'

module Connections
  RSpec.shared_examples "a connections query" do
    describe "#all" do
      it { expect(subject.all).to contain_exactly(*@matching) }
    end
    describe "#find_each" do
      it "iterates over matching events" do
        a = []
        subject.find_each do |act|
          a << act
        end
        expect(a).to contain_exactly(*@matching)
      end
    end
    describe "#include?" do
      it "includes only matching events" do
        @matching.each do |ma|
          expect(subject.include?(ma)).to be_truthy
        end
        @nonmatching.each do |noma|
          expect(subject.include?(noma)).to be_falsey
        end
      end
    end
  end

  RSpec.describe Query do
    include_context "connection variables"

    let(:connections) { SoftwareConnection.all }

    # check for class methods
    it { expect(Query.respond_to? :new).to be_truthy}

    it "raise an ArgumentError" do
    expect {
      Query.new
    }.to raise_error(ArgumentError)
    end

   # check for instance methods
    describe "instance methods" do
      subject { Query.new(connections) }
      it { expect(subject.respond_to? :all).to be_truthy}
      it { expect(subject.respond_to? :find_each).to be_truthy}
      it { expect(subject.respond_to? :include?).to be_truthy }
    end

   context "with unknown option :fasel" do
      subject { Query.new(connections, {fasel: 'blubb'}) }
      describe "#all" do
        it "raises a argument error" do
          expect { subject.all }.to raise_error(ArgumentError)
        end
      end
    end

    context "with :id" do
      subject { Query.new(connections, {id: c1.to_param}) }
      before(:each) do
        @matching = [c1]
        @nonmatching = [c2, c3, c4]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :source_connector_id" do
      subject { Query.new(connections, {source_connector_id: icmbarout.to_param}) }
      before(:each) do
        @matching = [c1, c3]
        @nonmatching = [c2, c4]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :destination_connector_id" do
      subject { Query.new(connections, {destination_connector_id: icmbarin.to_param}) }
      before(:each) do
        @matching = [c1, c4]
        @nonmatching = [c2, c3]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :location_id" do
      subject { Query.new(connections, {location_id: ber.to_param}) }
      before(:each) do
        @matching = [c2, c3, c4]
        @nonmatching = [c1]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :missing_connector" do
      subject { Query.new(connections, {missing_connector: :none}) }
      before(:each) do
        @matching = [c1]
        @nonmatching = [c2, c3, c4]
      end
      it_behaves_like "a connections query"
    end # :missing_connector

    context "with :missing_connector" do
      subject { Query.new(connections, {missing_connector: :any}) }
      before(:each) do
        @matching = [c2, c3, c4]
        @nonmatching = [c1]
      end
      it_behaves_like "a connections query"
    end # :missing_connector

    context "with :missing_connector" do
      subject { Query.new(connections, {missing_connector: :source}) }
      before(:each) do
        @matching = [c2, c4]
        @nonmatching = [c1, c3]
      end
      it_behaves_like "a connections query"
    end # :missing_connector

    context "with :missing_connector" do
      subject { Query.new(connections, {missing_connector: :destination}) }
      before(:each) do
        @matching = [c2, c3]
        @nonmatching = [c1, c4]
      end
      it_behaves_like "a connections query"
    end # :missing_connector

    context "with :missing_connector" do
      subject { Query.new(connections, {missing_connector: :both}) }
      before(:each) do
        @matching = [c2]
        @nonmatching = [c1, c3, c4]
      end
      it_behaves_like "a connections query"
    end # :missing_connector

    context "with :source_url" do
      subject { Query.new(connections, {source_url: '192.0.2.1:3005'}) }
      before(:each) do
        @matching = [c1, c3]
        @nonmatching = [c2, c4]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :destination_url" do
      subject { Query.new(connections, {destination_url: '9999'}) }
      before(:each) do
        @matching = [c2, c3]
        @nonmatching = [c1, c4]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :channel_id" do
      subject { Query.new(connections, {channel_id: '815'}) }
      before(:each) do
        @matching = [c1, c2, c3]
        @nonmatching = [c4]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :disabled_channels true" do
      subject { Query.new(connections, {disabled_channels: true}) }
      before(:each) do
        @matching = [c1, c4]
        @nonmatching = [c2, c3]
      end
      it_behaves_like "a connections query"
    end # :id

    context "with :disabled_channels false" do
      subject { Query.new(connections, {disabled_channels: false}) }
      before(:each) do
        @matching = [c2, c3]
        @nonmatching = [c1, c4]
      end
      it_behaves_like "a connections query"
    end # :id




    describe "#all" do
      context "using :search'" do
        it "searches for max" do
          skip
          search = Query.new(connections, {search: 'max'})
          expect(search.all).to contain_exactly(t1, to1, done1)
        end

        it "searches for status" do
          skip
          search = Query.new(connections, {search: 'warten'})
          expect(search.all).to contain_exactly(tl2)
        end
     
      end
    end
  end
end
