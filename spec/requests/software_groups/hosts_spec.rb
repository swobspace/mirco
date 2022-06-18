require 'rails_helper'

module SoftwareGroups
  RSpec.describe "/hosts", type: :request do
    let(:location) { FactoryBot.create(:location) }
    let(:software_group) { FactoryBot.create(:software_group) }

    let(:valid_attributes) do
      FactoryBot.attributes_for(:host, location_id: location.id, 
                                       software_group_id: software_group.id)
    end

    let(:post_attributes) do
      FactoryBot.attributes_for(:host, location_id: location.id)
    end

    let(:invalid_attributes) do
      { name: nil }
    end

    before(:each) do
      login_admin
    end

    describe "GET /index" do
      it "renders a successful response" do
        Host.create! valid_attributes
        get software_group_hosts_url(software_group)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        host = Host.create! valid_attributes
        get software_group_host_url(software_group, host)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_software_group_host_url(software_group)
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        host = Host.create! valid_attributes
        get edit_software_group_host_url(software_group, host)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Host" do
          expect {
            post software_group_hosts_url(software_group), params: { host: post_attributes }
          }.to change(Host, :count).by(1)
        end

        it "redirects to the created host" do
          post software_group_hosts_url(software_group), params: { host: post_attributes }
          expect(response).to redirect_to(software_group_url(software_group))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Host" do
          expect {
            post software_group_hosts_url(software_group), params: { host: invalid_attributes }
          }.to change(Host, :count).by(0)
        end

      
        it "renders a successful response (i.e. to display the 'new' template)" do
          post software_group_hosts_url(software_group), params: { host: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) do
          { ipaddress: '192.0.2.123' }
        end

        it "updates the requested host" do
          host = Host.create! valid_attributes
          patch software_group_host_url(software_group, host), params: { host: new_attributes }
          host.reload
          expect(host.ipaddress.to_s).to eq('192.0.2.123')
        end

        it "redirects to the host" do
          host = Host.create! valid_attributes
          patch software_group_host_url(software_group, host), params: { host: new_attributes }
          host.reload
          expect(response).to redirect_to(software_group_url(software_group))
        end
      end

      context "with invalid parameters" do
      
        it "renders a successful response (i.e. to display the 'edit' template)" do
          host = Host.create! valid_attributes
          patch software_group_host_url(software_group, host), params: { host: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested host" do
        host = Host.create! valid_attributes
        expect {
          delete software_group_host_url(software_group, host)
        }.to change(Host, :count).by(-1)
      end

      it "redirects to the hosts list" do
        host = Host.create! valid_attributes
        delete software_group_host_url(software_group, host)
        expect(response).to redirect_to(software_group_url(software_group))
      end
    end
  end
end
