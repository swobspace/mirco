require "rails_helper"

module Locations
  RSpec.describe HostsController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/locations/97/hosts").to route_to(controller: "locations/hosts", action: "index", location_id: "97")
      end

      it "routes to #new" do
        expect(get: "/locations/97/hosts/new").to route_to(controller: "locations/hosts", action: "new", location_id: "97")
      end

      it "routes to #show" do
        expect(get: "/locations/97/hosts/1").to route_to(controller: "locations/hosts", action: "show", id: "1", location_id: "97")
      end

      it "routes to #edit" do
        expect(get: "/locations/97/hosts/1/edit").to route_to(controller: "locations/hosts", action: "edit", id: "1", location_id: "97")
      end


      it "routes to #create" do
        expect(post: "/locations/97/hosts").to route_to(controller: "locations/hosts", action: "create", location_id: "97")
      end

      it "routes to #update via PUT" do
        expect(put: "/locations/97/hosts/1").to route_to(controller: "locations/hosts", action: "update", id: "1", location_id: "97")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/locations/97/hosts/1").to route_to(controller: "locations/hosts", action: "update", id: "1", location_id: "97")
      end

      it "routes to #destroy" do
        expect(delete: "/locations/97/hosts/1").to route_to(controller: "locations/hosts", action: "destroy", id: "1", location_id: "97")
      end
    end
  end
end
