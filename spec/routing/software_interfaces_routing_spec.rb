require "rails_helper"

RSpec.describe SoftwareInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software_interfaces").to route_to("software_interfaces#index")
    end

    it "routes to #new" do
      expect(get: "/software_interfaces/new").to route_to("software_interfaces#new")
    end

    it "routes to #show" do
      expect(get: "/software_interfaces/1").to route_to("software_interfaces#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/software_interfaces/1/edit").to route_to("software_interfaces#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/software_interfaces").to route_to("software_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/software_interfaces/1").to route_to("software_interfaces#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software_interfaces/1").to route_to("software_interfaces#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/software_interfaces/1").to route_to("software_interfaces#destroy", id: "1")
    end
  end
end
