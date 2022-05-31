require "rails_helper"

RSpec.describe SoftwareInterfaces::InterfaceConnectorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software_interfaces/99/interface_connectors").to route_to(controller: "software_interfaces/interface_connectors", action: "index", software_interface_id: "99")
    end

    it "routes to #new" do
      expect(get: "/software_interfaces/99/interface_connectors/new").to route_to(controller: "software_interfaces/interface_connectors", action: "new", software_interface_id: "99")
    end

    it "routes to #show" do
      expect(get: "/software_interfaces/99/interface_connectors/1").to route_to(controller: "software_interfaces/interface_connectors", action: "show", id: "1", software_interface_id: "99")
    end

    it "routes to #edit" do
      expect(get: "/software_interfaces/99/interface_connectors/1/edit").to route_to(controller: "software_interfaces/interface_connectors", action: "edit", id: "1", software_interface_id: "99")
    end


    it "routes to #create" do
      expect(post: "/software_interfaces/99/interface_connectors").to route_to(controller: "software_interfaces/interface_connectors", action: "create", software_interface_id: "99")
    end

    it "routes to #update via PUT" do
      expect(put: "/software_interfaces/99/interface_connectors/1").to route_to(controller: "software_interfaces/interface_connectors", action: "update", id: "1", software_interface_id: "99")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software_interfaces/99/interface_connectors/1").to route_to(controller: "software_interfaces/interface_connectors", action: "update", id: "1", software_interface_id: "99")
    end

    it "routes to #destroy" do
      expect(delete: "/software_interfaces/99/interface_connectors/1").to route_to(controller: "software_interfaces/interface_connectors", action: "destroy", id: "1", software_interface_id: "99")
    end
  end
end
