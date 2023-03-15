require 'rails_helper'

RSpec.describe "/notification_groups", type: :request do
  
  let(:valid_attributes) {
    FactoryBot.attributes_for(:notification_group)
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      NotificationGroup.create! valid_attributes
      get notification_groups_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      notification_group = NotificationGroup.create! valid_attributes
      get notification_group_url(notification_group)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_notification_group_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      notification_group = NotificationGroup.create! valid_attributes
      get edit_notification_group_url(notification_group)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new NotificationGroup" do
        expect {
          post notification_groups_url, params: { notification_group: valid_attributes }
        }.to change(NotificationGroup, :count).by(1)
      end

      it "redirects to the created notification_group" do
        post notification_groups_url, params: { notification_group: valid_attributes }
        expect(response).to redirect_to(notification_group_url(NotificationGroup.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new NotificationGroup" do
        expect {
          post notification_groups_url, params: { notification_group: invalid_attributes }
        }.to change(NotificationGroup, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post notification_groups_url, params: { notification_group: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'NewName' }
      }

      it "updates the requested notification_group" do
        notification_group = NotificationGroup.create! valid_attributes
        patch notification_group_url(notification_group), params: { notification_group: new_attributes }
        notification_group.reload
        expect(notification_group.name).to eq("NewName")
      end

      it "redirects to the notification_group" do
        notification_group = NotificationGroup.create! valid_attributes
        patch notification_group_url(notification_group), params: { notification_group: new_attributes }
        notification_group.reload
        expect(response).to redirect_to(notification_group_url(notification_group))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        notification_group = NotificationGroup.create! valid_attributes
        patch notification_group_url(notification_group), params: { notification_group: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested notification_group" do
      notification_group = NotificationGroup.create! valid_attributes
      expect {
        delete notification_group_url(notification_group)
      }.to change(NotificationGroup, :count).by(-1)
    end

    it "redirects to the notification_groups list" do
      notification_group = NotificationGroup.create! valid_attributes
      delete notification_group_url(notification_group)
      expect(response).to redirect_to(notification_groups_url)
    end
  end
end
