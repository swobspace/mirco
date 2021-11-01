require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/channels/88/notes").to route_to("channels/notes#index", channel_id: "88")
    end

    it "routes to #new" do
      expect(get: "/channels/88/notes/new").to route_to("channels/notes#new", channel_id: "88")
    end

    it "routes to #show" do
      expect(get: "/channels/88/notes/1").to route_to("channels/notes#show", id: "1", channel_id: "88")
    end

    it "routes to #edit" do
      expect(get: "/channels/88/notes/1/edit").to route_to("channels/notes#edit", id: "1", channel_id: "88")
    end


    it "routes to #create" do
      expect(post: "/channels/88/notes").to route_to("channels/notes#create", channel_id: "88")
    end

    it "routes to #update via PUT" do
      expect(put: "/channels/88/notes/1").to route_to("channels/notes#update", id: "1", channel_id: "88")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/channels/88/notes/1").to route_to("channels/notes#update", id: "1", channel_id: "88")
    end

    it "routes to #destroy" do
      expect(delete: "/channels/88/notes/1").to route_to("channels/notes#destroy", id: "1", channel_id: "88")
    end
  end
end
