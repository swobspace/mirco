require "rails_helper"

module Hosts
  RSpec.describe SoftwareInterfacesController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/hosts/99/software_interfaces").to route_to(controller: "hosts/software_interfaces", action: "index", host_id: "99")
      end

      it "routes to #new" do
        expect(get: "/hosts/99/software_interfaces/new").to route_to(controller: "hosts/software_interfaces", action: "new", host_id: "99")
      end

      it "routes to #show" do
        expect(get: "/hosts/99/software_interfaces/1").to route_to(controller: "hosts/software_interfaces", action: "show", id: "1", host_id: "99")
      end

      it "routes to #edit" do
        expect(get: "/hosts/99/software_interfaces/1/edit").to route_to(controller: "hosts/software_interfaces", action: "edit", id: "1", host_id: "99")
      end


      it "routes to #create" do
        expect(post: "/hosts/99/software_interfaces").to route_to(controller: "hosts/software_interfaces", action: "create", host_id: "99")
      end

      it "routes to #update via PUT" do
        expect(put: "/hosts/99/software_interfaces/1").to route_to(controller: "hosts/software_interfaces", action: "update", id: "1", host_id: "99")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/hosts/99/software_interfaces/1").to route_to(controller: "hosts/software_interfaces", action: "update", id: "1", host_id: "99")
      end

      it "routes to #destroy" do
        expect(delete: "/hosts/99/software_interfaces/1").to route_to(controller: "hosts/software_interfaces", action: "destroy", id: "1", host_id: "99")
      end
    end
  end
end
