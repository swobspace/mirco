require 'rails_helper'
module System
  RSpec.describe FetchParams do
    let!(:server) { FactoryBot.create(:server, 
      api_url: ENV['API_URL'],
      api_user: ENV['API_USER'], 
      api_password: ENV['API_PASSWORD'],
      api_verify_ssl: ENV['API_VERIFY_SSL']
    )}
    subject { System::FetchParams.new(server: server) }

    it "shows params" do
      puts server.inspect
    end
    # check for instance methods
    describe "check if instance methods exists" do
      it { expect(subject.respond_to? :call).to be_truthy}
      it { expect(subject.call.respond_to? :success?).to be_truthy }
      it { expect(subject.call.respond_to? :error_messages).to be_truthy }
      it { expect(subject.call.respond_to? :params).to be_truthy }
    end

    describe "#call" do
     let(:result) { subject.call }
      it { expect(result.success?).to be_truthy }
      it { expect(result.error_messages.present?).to be_falsey }
      it { expect(result.params).to be_present }
      it { puts result.params.inspect }
    end



  end
end
