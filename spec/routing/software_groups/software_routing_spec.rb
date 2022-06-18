require "rails_helper"

module SoftwareGroups
  RSpec.describe SoftwareController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/software_groups/97/software").to route_to(controller: "software_groups/software", action: "index", software_group_id: "97")
      end

      it "routes to #new" do
        expect(get: "/software_groups/97/software/new").to route_to(controller: "software_groups/software", action: "new", software_group_id: "97")
      end

      it "routes to #show" do
        expect(get: "/software_groups/97/software/1").to route_to(controller: "software_groups/software", action: "show", id: "1", software_group_id: "97")
      end

      it "routes to #edit" do
        expect(get: "/software_groups/97/software/1/edit").to route_to(controller: "software_groups/software", action: "edit", id: "1", software_group_id: "97")
      end


      it "routes to #create" do
        expect(post: "/software_groups/97/software").to route_to(controller: "software_groups/software", action: "create", software_group_id: "97")
      end

      it "routes to #update via PUT" do
        expect(put: "/software_groups/97/software/1").to route_to(controller: "software_groups/software", action: "update", id: "1", software_group_id: "97")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/software_groups/97/software/1").to route_to(controller: "software_groups/software", action: "update", id: "1", software_group_id: "97")
      end

      it "routes to #destroy" do
        expect(delete: "/software_groups/97/software/1").to route_to(controller: "software_groups/software", action: "destroy", id: "1", software_group_id: "97")
      end
    end
  end
end
