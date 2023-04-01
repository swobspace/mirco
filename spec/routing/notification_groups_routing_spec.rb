require "rails_helper"

RSpec.describe NotificationGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/notification_groups").to route_to("notification_groups#index")
    end

    it "routes to #new" do
      expect(get: "/notification_groups/new").to route_to("notification_groups#new")
    end

    it "routes to #show" do
      expect(get: "/notification_groups/1").to route_to("notification_groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/notification_groups/1/edit").to route_to("notification_groups#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/notification_groups").to route_to("notification_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/notification_groups/1").to route_to("notification_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/notification_groups/1").to route_to("notification_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/notification_groups/1").to route_to("notification_groups#destroy", id: "1")
    end
  end
end
