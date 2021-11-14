require "rails_helper"

RSpec.describe Servers::AlertsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/servers/88/alerts").to route_to("servers/alerts#index", server_id: "88")
    end

    it "routes to #new" do
      skip "needs more grips"
      expect(get: "/servers/88/alerts/new").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/servers/88/alerts/1").to route_to("servers/alerts#show", id: "1", server_id: "88")
    end

    it "routes to #edit" do
      expect(get: "/servers/88/alerts/1/edit").not_to be_routable
    end


    it "routes to #create" do
      expect(post: "/servers/88/alerts").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "/servers/88/alerts/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/servers/88/alerts/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/servers/88/alerts/1").not_to be_routable
    end
  end
end
