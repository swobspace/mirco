require 'rails_helper'

module SoftwareGroups
  RSpec.describe "/software", type: :request do
    let(:location) { FactoryBot.create(:location) }
    let(:software_group) { FactoryBot.create(:software_group) }

    let(:valid_attributes) do
      FactoryBot.attributes_for(:software, location_id: location.id, 
                                           software_group_id: software_group.id)
    end

    let(:post_attributes) do
      FactoryBot.attributes_for(:software, location_id: location.id)
    end

    let(:invalid_attributes) do
      { name: nil }
    end

    before(:each) do
      login_admin
    end

    describe "GET /index" do
      it "renders a successful response" do
        Software.create! valid_attributes
        get software_group_software_index_url(software_group)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        software = Software.create! valid_attributes
        get software_group_software_url(software_group, software)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_software_group_software_url(software_group)
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        software = Software.create! valid_attributes
        get edit_software_group_software_url(software_group, software)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Software" do
          expect {
            post software_group_software_index_url(software_group), params: { software: post_attributes }
          }.to change(Software, :count).by(1)
        end

        it "redirects to the created software" do
          post software_group_software_index_url(software_group), params: { software: post_attributes }
          expect(response).to redirect_to(software_group_url(software_group))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Software" do
          expect {
            post software_group_software_index_url(software_group), params: { software: invalid_attributes }
          }.to change(Software, :count).by(0)
        end

      
        it "renders a successful response (i.e. to display the 'new' template)" do
          post software_group_software_index_url(software_group), params: { software: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) do
          { description: 'some other text' }
        end

        it "updates the requested software" do
          software = Software.create! valid_attributes
          patch software_group_software_url(software_group, software), params: { software: new_attributes }
          software.reload
          expect(software.description.to_s).to match('some other text')
        end

        it "redirects to the software" do
          software = Software.create! valid_attributes
          patch software_group_software_url(software_group, software), params: { software: new_attributes }
          software.reload
          expect(response).to redirect_to(software_group_url(software_group))
        end
      end

      context "with invalid parameters" do
      
        it "renders a successful response (i.e. to display the 'edit' template)" do
          software = Software.create! valid_attributes
          patch software_group_software_url(software_group, software), params: { software: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested software" do
        software = Software.create! valid_attributes
        expect {
          delete software_group_software_url(software_group, software)
        }.to change(Software, :count).by(-1)
      end

      it "redirects to the software list" do
        software = Software.create! valid_attributes
        delete software_group_software_url(software_group, software)
        expect(response).to redirect_to(software_group_url(software_group))
      end
    end
  end
end
