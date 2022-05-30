require "rails_helper"

RSpec.describe Software::SoftwareInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/software/99/software_interfaces").to route_to(controller: "software/software_interfaces", action: "index", software_id: "99")
    end

    it "routes to #new" do
      expect(get: "/software/99/software_interfaces/new").to route_to(controller: "software/software_interfaces", action: "new", software_id: "99")
    end

    it "routes to #show" do
      expect(get: "/software/99/software_interfaces/1").to route_to(controller: "software/software_interfaces", action: "show", id: "1", software_id: "99")
    end

    it "routes to #edit" do
      expect(get: "/software/99/software_interfaces/1/edit").to route_to(controller: "software/software_interfaces", action: "edit", id: "1", software_id: "99")
    end


    it "routes to #create" do
      expect(post: "/software/99/software_interfaces").to route_to(controller: "software/software_interfaces", action: "create", software_id: "99")
    end

    it "routes to #update via PUT" do
      expect(put: "/software/99/software_interfaces/1").to route_to(controller: "software/software_interfaces", action: "update", id: "1", software_id: "99")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/software/99/software_interfaces/1").to route_to(controller: "software/software_interfaces", action: "update", id: "1", software_id: "99")
    end

    it "routes to #destroy" do
      expect(delete: "/software/99/software_interfaces/1").to route_to(controller: "software/software_interfaces", action: "destroy", id: "1", software_id: "99")
    end
  end
end
