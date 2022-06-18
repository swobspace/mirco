require 'rails_helper'

RSpec.describe "/software_groups", type: :request do
  
  let(:valid_attributes) do
    FactoryBot.attributes_for(:software_group)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      SoftwareGroup.create! valid_attributes
      get software_groups_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      software_group = SoftwareGroup.create! valid_attributes
      get software_group_url(software_group)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_software_group_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      software_group = SoftwareGroup.create! valid_attributes
      get edit_software_group_url(software_group)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SoftwareGroup" do
        expect {
          post software_groups_url, params: { software_group: valid_attributes }
        }.to change(SoftwareGroup, :count).by(1)
      end

      it "redirects to the created software_group" do
        post software_groups_url, params: { software_group: valid_attributes }
        expect(response).to redirect_to(software_group_url(SoftwareGroup.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SoftwareGroup" do
        expect {
          post software_groups_url, params: { software_group: invalid_attributes }
        }.to change(SoftwareGroup, :count).by(0)
      end

    
      it "renders a successful response (i.e. to display the 'new' template)" do
        post software_groups_url, params: { software_group: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { description: "describe it again" }
      end

      it "updates the requested software_group" do
        software_group = SoftwareGroup.create! valid_attributes
        patch software_group_url(software_group), params: { software_group: new_attributes }
        software_group.reload
        expect(software_group.description).to eq("describe it again")
      end

      it "redirects to the software_group" do
        software_group = SoftwareGroup.create! valid_attributes
        patch software_group_url(software_group), params: { software_group: new_attributes }
        software_group.reload
        expect(response).to redirect_to(software_group_url(software_group))
      end
    end

    context "with invalid parameters" do
    
      it "renders a successful response (i.e. to display the 'edit' template)" do
        software_group = SoftwareGroup.create! valid_attributes
        patch software_group_url(software_group), params: { software_group: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested software_group" do
      software_group = SoftwareGroup.create! valid_attributes
      expect {
        delete software_group_url(software_group)
      }.to change(SoftwareGroup, :count).by(-1)
    end

    it "redirects to the software_groups list" do
      software_group = SoftwareGroup.create! valid_attributes
      delete software_group_url(software_group)
      expect(response).to redirect_to(software_groups_url)
    end
  end
end
