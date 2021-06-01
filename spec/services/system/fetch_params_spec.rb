require 'rails_helper'
module System
  RSpec.describe FetchParams do
    let!(:server) { FactoryBot.create(:server, 
      api_user: ENV['API_USER'], 
      api_password: ENV['API_PASSWORD'],
      api_verify_ssl: ENV['API_VERIFY_SSL']
    )}
    subject { System::FetchParams.new(server: server) }

    # check for instance methods
    describe "instance methods" do
      it { expect(subject.respond_to? :call).to be_truthy}
      it { expect(subject.call.respond_to? :success?).to be_truthy }
      it { expect(subject.call.respond_to? :error_messages).to be_truthy }
      it { expect(subject.call.respond_to? :params).to be_truthy }
    end

  end
end
