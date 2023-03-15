require "rails_helper"

module EscalationLevels
  RSpec.describe EscalationTimesController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/escalation_levels/99/escalation_times").to route_to(controller: "escalation_levels/escalation_times", action: "index", escalation_level_id: "99")
      end

      it "routes to #new" do
        expect(get: "/escalation_levels/99/escalation_times/new").to route_to(controller: "escalation_levels/escalation_times", action: "new", escalation_level_id: "99")
      end

      it "routes to #show" do
        expect(get: "/escalation_levels/99/escalation_times/1").to route_to(controller: "escalation_levels/escalation_times", action: "show", id: "1", escalation_level_id: "99")
      end

      it "routes to #edit" do
        expect(get: "/escalation_levels/99/escalation_times/1/edit").to route_to(controller: "escalation_levels/escalation_times", action: "edit", id: "1", escalation_level_id: "99")
      end


      it "routes to #create" do
        expect(post: "/escalation_levels/99/escalation_times").to route_to(controller: "escalation_levels/escalation_times", action: "create", escalation_level_id: "99")
      end

      it "routes to #update via PUT" do
        expect(put: "/escalation_levels/99/escalation_times/1").to route_to(controller: "escalation_levels/escalation_times", action: "update", id: "1", escalation_level_id: "99")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/escalation_levels/99/escalation_times/1").to route_to(controller: "escalation_levels/escalation_times", action: "update", id: "1", escalation_level_id: "99")
      end

      it "routes to #destroy" do
        expect(delete: "/escalation_levels/99/escalation_times/1").to route_to(controller: "escalation_levels/escalation_times", action: "destroy", id: "1", escalation_level_id: "99")
      end
    end
  end
end
