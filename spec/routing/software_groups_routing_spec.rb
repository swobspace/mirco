require "rails_helper"

RSpec.describe SoftwareGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software_groups").to route_to("software_groups#index")
    end

    it "routes to #new" do
      expect(get: "/software_groups/new").to route_to("software_groups#new")
    end

    it "routes to #show" do
      expect(get: "/software_groups/1").to route_to("software_groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/software_groups/1/edit").to route_to("software_groups#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/software_groups").to route_to("software_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/software_groups/1").to route_to("software_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software_groups/1").to route_to("software_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/software_groups/1").to route_to("software_groups#destroy", id: "1")
    end
  end
end
