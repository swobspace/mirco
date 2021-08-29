require "rails_helper"

RSpec.describe ChannelCountersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/channel_counters").to route_to("channel_counters#index")
    end
  end
end
