require "rails_helper"

RSpec.describe ChannelStatisticGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/channel_statistic_groups").to route_to("channel_statistic_groups#index")
    end

    it "routes to #new" do
      expect(get: "/channel_statistic_groups/new").to route_to("channel_statistic_groups#new")
    end

    it "routes to #show" do
      expect(get: "/channel_statistic_groups/1").to route_to("channel_statistic_groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/channel_statistic_groups/1/edit").to route_to("channel_statistic_groups#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/channel_statistic_groups").to route_to("channel_statistic_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/channel_statistic_groups/1").to route_to("channel_statistic_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/channel_statistic_groups/1").to route_to("channel_statistic_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/channel_statistic_groups/1").to route_to("channel_statistic_groups#destroy", id: "1")
    end
  end
end
