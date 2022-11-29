require "rails_helper"

RSpec.describe EscalationLevelsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/escalation_levels").to route_to("escalation_levels#index")
    end

    it "routes to #new" do
      expect(get: "/escalation_levels/new").to route_to("escalation_levels#new")
    end

    it "routes to #show" do
      expect(get: "/escalation_levels/1").to route_to("escalation_levels#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/escalation_levels/1/edit").to route_to("escalation_levels#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/escalation_levels").to route_to("escalation_levels#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/escalation_levels/1").to route_to("escalation_levels#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/escalation_levels/1").to route_to("escalation_levels#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/escalation_levels/1").to route_to("escalation_levels#destroy", id: "1")
    end
  end
end
