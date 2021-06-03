require "rails_helper"

RSpec.describe ChannelsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/servers/99/channels").to route_to("channels#index", server_id: "99")
    end

    it "routes to #new" do
      pending "needs more grips"
      expect(get: "/servers/99/channels/new").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/servers/99/channels/1").to route_to("channels#show", id: "1", server_id: "99")
    end

    it "routes to #edit" do
      expect(get: "/servers/99/channels/1/edit").not_to be_routable
    end


    it "routes to #create" do
      expect(post: "/servers/99/channels").not_to be_routable
    end

    it "routes to #fetch_all" do
      expect(post: "/servers/99/channels/fetch_all").to route_to("channels#fetch_all", server_id: "99")
    end


    it "routes to #update via PUT" do
      expect(put: "/servers/99/channels/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/servers/99/channels/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/servers/99/channels/1").to route_to("channels#destroy", id: "1", server_id: "99")
    end
  end
end
