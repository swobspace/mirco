require 'rails_helper'

module SoftwareInterfaces
  RSpec.describe "/interface_connectors", type: :request do
    let(:software_interface) { FactoryBot.create(:software_interface) }
    
    let(:valid_attributes) do
      FactoryBot.attributes_for(:interface_connector, 
        software_interface_id: software_interface.id
      )
    end

    let(:post_attributes) do
      FactoryBot.attributes_for(:interface_connector)
    end

    let(:invalid_attributes) do
      { name: nil }
    end

    before(:each) do
      login_admin
    end

    describe "GET /index" do
      it "renders a successful response" do
        InterfaceConnector.create! valid_attributes
        get software_interface_interface_connectors_url(software_interface)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        interface_connector = InterfaceConnector.create! valid_attributes
        get software_interface_interface_connector_url(software_interface, interface_connector)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_software_interface_interface_connector_url(software_interface)
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        interface_connector = InterfaceConnector.create! valid_attributes
        get edit_software_interface_interface_connector_url(software_interface, interface_connector)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new InterfaceConnector" do
          expect {
            post software_interface_interface_connectors_url(software_interface), 
                   params: { interface_connector: valid_attributes }
          }.to change(InterfaceConnector, :count).by(1)
        end

        it "redirects to the created interface_connector" do
          post software_interface_interface_connectors_url(software_interface), 
                 params: { interface_connector: valid_attributes }
          expect(response).to redirect_to(software_interface_url(software_interface))
        end
      end

      context "with invalid parameters" do
        it "does not create a new InterfaceConnector" do
          expect {
            post software_interface_interface_connectors_url(software_interface), 
                   params: { interface_connector: invalid_attributes }
          }.to change(InterfaceConnector, :count).by(0)
        end

      
        it "renders a successful response (i.e. to display the 'new' template)" do
          post software_interface_interface_connectors_url(software_interface), 
                 params: { interface_connector: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) do
          { name: 'BAR out', description: 'sending ICD/OPS codes' }
        end

        it "updates the requested interface_connector" do
          interface_connector = InterfaceConnector.create! valid_attributes
          patch software_interface_interface_connector_url(software_interface, interface_connector), params: { interface_connector: new_attributes }
          interface_connector.reload
          expect(interface_connector.name).to eq("BAR out")
          expect(interface_connector.description.to_plain_text).to eq("sending ICD/OPS codes")
        end

        it "redirects to the interface_connector" do
          interface_connector = InterfaceConnector.create! valid_attributes
          patch software_interface_interface_connector_url(software_interface,interface_connector), params: { interface_connector: new_attributes }
          interface_connector.reload
          expect(response).to redirect_to(software_interface_url(software_interface))
        end
      end

      context "with invalid parameters" do
      
        it "renders a successful response (i.e. to display the 'edit' template)" do
          interface_connector = InterfaceConnector.create! valid_attributes
          patch software_interface_interface_connector_url(software_interface, interface_connector), params: { interface_connector: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested interface_connector" do
        interface_connector = InterfaceConnector.create! valid_attributes
        expect {
          delete software_interface_interface_connector_url(software_interface, interface_connector)
        }.to change(InterfaceConnector, :count).by(-1)
      end

      it "redirects to the interface_connectors list" do
        interface_connector = InterfaceConnector.create! valid_attributes
        delete software_interface_interface_connector_url(software_interface,interface_connector)
        expect(response).to redirect_to(software_interface_url(software_interface))
      end
    end
  end
end
