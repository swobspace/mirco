require "rails_helper"

RSpec.describe ChannelStatisticsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/channel_statistics").to route_to("channel_statistics#index")
    end

    it "routes to #new" do
      pending "needs more grips"
      expect(get: "/channel_statistics/new").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/channel_statistics/1").to route_to("channel_statistics#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/channel_statistics/1/edit").not_to be_routable
    end


    it "routes to #create" do
      expect(post: "/channel_statistics").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "/channel_statistics/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/channel_statistics/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/channel_statistics/1").not_to be_routable
    end
  end
end