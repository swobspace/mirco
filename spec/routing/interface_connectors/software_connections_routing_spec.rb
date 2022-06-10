require "rails_helper"

module InterfaceConnections
  RSpec.describe SoftwareConnectionsController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/interface_connectors/88/software_connections").to route_to(controller: "interface_connectors/software_connections", action: "index", interface_connector_id: "88")
      end

      it "routes to #new" do
        expect(get: "/interface_connectors/88/software_connections/new").not_to be_routable
      end

      it "routes to #show" do
        expect(get: "/interface_connectors/88/software_connections/1").not_to be_routable
      end

      it "routes to #edit" do
        expect(get: "/interface_connectors/88/software_connections/1/edit").not_to be_routable
      end


      it "routes to #create" do
        expect(post: "/interface_connectors/88/software_connections").not_to be_routable
      end

      it "routes to #update via PUT" do
        expect(put: "/interface_connectors/88/software_connections/1").to route_to(controller: "interface_connectors/software_connections", action: "update", id: "1", interface_connector_id: "88")
      end

      it "routes to #destroy" do
        expect(delete: "/interface_connectors/88/software_connections/1").not_to be_routable
      end
    end
  end
end
