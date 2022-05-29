require "rails_helper"

RSpec.describe InterfaceConnectorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/interface_connectors").to route_to("interface_connectors#index")
    end

    it "routes to #new" do
      expect(get: "/interface_connectors/new").to route_to("interface_connectors#new")
    end

    it "routes to #show" do
      expect(get: "/interface_connectors/1").to route_to("interface_connectors#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/interface_connectors/1/edit").to route_to("interface_connectors#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/interface_connectors").to route_to("interface_connectors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/interface_connectors/1").to route_to("interface_connectors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/interface_connectors/1").to route_to("interface_connectors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/interface_connectors/1").to route_to("interface_connectors#destroy", id: "1")
    end
  end
end
