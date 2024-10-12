# frozen_string_literal: true

require 'rails_helper'
module Notes
  RSpec.describe Processor do
    let!(:ts)   { Time.current }
    let(:server) { FactoryBot.create(:server) }
    let(:note) do 
      FactoryBot.create(:note, 
        notable: server,
        type: 'acknowledge',
        message: "some more information"
      )
    end

    subject { Notes::Processor.new(note: note) }

    # check for instance methods
    describe 'check if instance methods exists' do
      it { expect(subject).to be_kind_of(Notes::Processor) }
      it { expect(subject.respond_to?(:call)).to be_truthy }
    end

    describe '#new' do
      context 'without params' do
        it 'raises a KeyError' do
          expect do
            Processor.new()
          end.to raise_error(KeyError)
        end
      end
    end

    describe '#call(nix)' do
      it "raises a runtime error" do
        expect {
          subject.call(:nix)
        }.to raise_error(RuntimeError)
      end
    end

    describe '#call(create)' do
      it "updates server.acknowledge to new ack" do
        expect(server.acknowledge).to be_nil
        subject.call(:create)
        server.reload
        expect(server.acknowledge_id).to eq(note.id)
      end
    end

    describe '#call(update)' do
      context "with current ack" do
        it "updates server.acknowledge" do
          expect(server.acknowledge).to be_nil
          subject.call(:update)
          server.reload
          expect(server.acknowledge_id).to eq(note.id)
        end
      end

      context "with outdated ack" do
        it "deletes server.acknowledge" do
          server.update(acknowledge_id: note.id)
          server.reload
          expect(server.acknowledge_id).to eq(note.id)
          note.update(valid_until: 1.day.before(Time.current))
          subject.call(:update)
          server.reload
          expect(server.acknowledge_id).to be_nil
        end
      end
    end

    describe '#call(destroy)' do
      it "updates server.acknowledge to nil" do
        server.update(acknowledge_id: note.id)
        server.reload
        expect(server.acknowledge_id).to eq(note.id)
        note.destroy
        subject.call(:destroy)
        server.reload
        expect(server.acknowledge_id).to be_nil
      end
    end

  end
end
