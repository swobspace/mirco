require "rails_helper"

RSpec.describe EscalationTimesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/escalation_times").to route_to("escalation_times#index")
    end

    it "routes to #new" do
      expect(get: "/escalation_times/new").to route_to("escalation_times#new")
    end

    it "routes to #show" do
      expect(get: "/escalation_times/1").to route_to("escalation_times#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/escalation_times/1/edit").to route_to("escalation_times#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/escalation_times").to route_to("escalation_times#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/escalation_times/1").to route_to("escalation_times#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/escalation_times/1").to route_to("escalation_times#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/escalation_times/1").to route_to("escalation_times#destroy", id: "1")
    end
  end
end
