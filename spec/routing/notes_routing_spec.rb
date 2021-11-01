require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/notes").not_to be_routable
    end

    it "routes to #new" do
      expect(get: "/notes/new").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/notes/1").not_to be_routable
    end

    it "routes to #edit" do
      expect(get: "/notes/1/edit").not_to be_routable
    end


    it "routes to #create" do
      expect(post: "/notes").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "/notes/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/notes/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/notes/1").not_to be_routable
    end
  end
end
