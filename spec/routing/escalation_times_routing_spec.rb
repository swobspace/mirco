require "rails_helper"

RSpec.describe EscalationTimesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/escalation_times").not_to be_routable
    end

    it "routes to #new" do
      expect(get: "/escalation_times/new").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/escalation_times/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(get: "/escalation_times/1/edit").not_to be_routable
    end


    it "routes to #create" do
      expect(post: "/escalation_times").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "/escalation_times/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/escalation_times/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/escalation_times/1").not_to be_routable
    end
  end
end
