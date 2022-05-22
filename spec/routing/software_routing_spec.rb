require "rails_helper"

RSpec.describe SoftwareController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software").to route_to("software#index")
    end

    it "routes to #new" do
      expect(get: "/software/new").to route_to("software#new")
    end

    it "routes to #show" do
      expect(get: "/software/1").to route_to("software#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/software/1/edit").to route_to("software#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/software").to route_to("software#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/software/1").to route_to("software#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software/1").to route_to("software#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/software/1").to route_to("software#destroy", id: "1")
    end
  end
end
