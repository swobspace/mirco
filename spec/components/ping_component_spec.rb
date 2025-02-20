# frozen_string_literal: true

require "rails_helper"

RSpec.describe PingComponent, type: :component do
  describe "with host" do
    let(:server) { FactoryBot.create(:server) }
    let(:host)   { FactoryBot.create(:host, ipaddress: '127.1.2.3') }

    describe "with host" do
      before(:each) do
        expect(server).to receive(:host).at_least(:once).and_return(host)
      end

      it "checks for ping, delivers reachable" do
        render_inline(described_class.new(pingable: server))
        expect(page).to have_css('div[class="toast align-items-center border-0 text-white bg-info"]')
      end

      it "checks for ping, delivers not reachable" do
        expect(server).to receive(:up?).and_return(false)
        render_inline(described_class.new(pingable: server))
        expect(page).to have_css('div[class="toast align-items-center border-0 text-white bg-danger"]')
      end
    end

    describe "without host" do
      it "does not check" do
        render_inline(described_class.new(pingable: server))
        expect(page).not_to have_css('div[id="liveToast"]')
      end
    end
  end
end
