require "rails_helper"

RSpec.describe SoftwareConnectionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software_connections").to route_to("software_connections#index")
    end

    it "routes to #search" do
      expect(get: "/software_connections/search").to route_to("software_connections#search")
    end

    it "routes to #new" do
      expect(get: "/software_connections/new").to route_to("software_connections#new")
    end

    it "routes to #show" do
      expect(get: "/software_connections/1").to route_to("software_connections#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/software_connections/1/edit").to route_to("software_connections#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/software_connections").to route_to("software_connections#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/software_connections/1").to route_to("software_connections#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software_connections/1").to route_to("software_connections#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/software_connections/1").to route_to("software_connections#destroy", id: "1")
    end
  end
end
