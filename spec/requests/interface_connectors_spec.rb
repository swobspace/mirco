require 'rails_helper'

RSpec.describe "/interface_connectors", type: :request do
  let(:swif) { FactoryBot.create(:software_interface) }
  
  let(:valid_attributes) do
    FactoryBot.attributes_for(:interface_connector, software_interface_id: swif.id)
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
      get interface_connectors_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      interface_connector = InterfaceConnector.create! valid_attributes
      get interface_connector_url(interface_connector)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_interface_connector_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      interface_connector = InterfaceConnector.create! valid_attributes
      get edit_interface_connector_url(interface_connector)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new InterfaceConnector" do
        expect {
          post interface_connectors_url, params: { interface_connector: valid_attributes }
        }.to change(InterfaceConnector, :count).by(1)
      end

      it "redirects to the created interface_connector" do
        post interface_connectors_url, params: { interface_connector: valid_attributes }
        expect(response).to redirect_to(interface_connector_url(InterfaceConnector.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new InterfaceConnector" do
        expect {
          post interface_connectors_url, params: { interface_connector: invalid_attributes }
        }.to change(InterfaceConnector, :count).by(0)
      end

    
      it "renders a successful response (i.e. to display the 'new' template)" do
        post interface_connectors_url, params: { interface_connector: invalid_attributes }
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
        patch interface_connector_url(interface_connector), params: { interface_connector: new_attributes }
        interface_connector.reload
        expect(interface_connector.name).to eq("BAR out")
        expect(interface_connector.description.to_plain_text).to eq("sending ICD/OPS codes")
      end

      it "redirects to the interface_connector" do
        interface_connector = InterfaceConnector.create! valid_attributes
        patch interface_connector_url(interface_connector), params: { interface_connector: new_attributes }
        interface_connector.reload
        expect(response).to redirect_to(interface_connector_url(interface_connector))
      end
    end

    context "with invalid parameters" do
    
      it "renders a successful response (i.e. to display the 'edit' template)" do
        interface_connector = InterfaceConnector.create! valid_attributes
        patch interface_connector_url(interface_connector), params: { interface_connector: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested interface_connector" do
      interface_connector = InterfaceConnector.create! valid_attributes
      expect {
        delete interface_connector_url(interface_connector)
      }.to change(InterfaceConnector, :count).by(-1)
    end

    it "redirects to the interface_connectors list" do
      interface_connector = InterfaceConnector.create! valid_attributes
      delete interface_connector_url(interface_connector)
      expect(response).to redirect_to(interface_connectors_url)
    end
  end
end
