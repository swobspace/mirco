require "rails_helper"

module ChannelStatisticGroups
  RSpec.describe EscalationLevelsController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/channel_statistic_groups/99/escalation_levels").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "index", channel_statistic_group_id: "99")
      end

      it "routes to #new" do
        expect(get: "/channel_statistic_groups/99/escalation_levels/new").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "new", channel_statistic_group_id: "99")
      end

      it "routes to #show" do
        expect(get: "/channel_statistic_groups/99/escalation_levels/1").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "show", id: "1", channel_statistic_group_id: "99")
      end

      it "routes to #edit" do
        expect(get: "/channel_statistic_groups/99/escalation_levels/1/edit").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "edit", id: "1", channel_statistic_group_id: "99")
      end


      it "routes to #create" do
        expect(post: "/channel_statistic_groups/99/escalation_levels").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "create", channel_statistic_group_id: "99")
      end

      it "routes to #update via PUT" do
        expect(put: "/channel_statistic_groups/99/escalation_levels/1").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "update", id: "1", channel_statistic_group_id: "99")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/channel_statistic_groups/99/escalation_levels/1").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "update", id: "1", channel_statistic_group_id: "99")
      end

      it "routes to #destroy" do
        expect(delete: "/channel_statistic_groups/99/escalation_levels/1").to route_to(controller: "channel_statistic_groups/escalation_levels", action: "destroy", id: "1", channel_statistic_group_id: "99")
      end
    end
  end
end
