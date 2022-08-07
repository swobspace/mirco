require 'rails_helper'

RSpec.describe "/software_connections", type: :request do

  let(:server) { FactoryBot.create(:server) }
  let(:location) { FactoryBot.create(:location) }
  let(:srcconn) { FactoryBot.create(:interface_connector) }
  let(:dstconn) { FactoryBot.create(:interface_connector) }
  
  let(:valid_attributes) do
    FactoryBot.attributes_for(:software_connection, 
      location_id: location.id, 
      server_id: server.id
    )
  end

  let(:invalid_attributes) do
    { location_id: nil, source_url: nil }
  end

  before(:each) do
    login_admin
  end

  describe "GET /search" do
    include_context "connection variables"

    it "renders a successful response" do
      SoftwareConnection.create! valid_attributes
      get search_software_connections_url
      expect(response).to be_successful
    end
  end

  describe "GET /index" do
    include_context "connection variables"

    it "renders a successful response" do
      SoftwareConnection.create! valid_attributes
      get software_connections_url
      expect(response).to be_successful
    end

    it "filters software connections" do
      get software_connections_url(missing_connector: :any)
      expect(assigns(:software_connections)).to contain_exactly(c2, c3, c4)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      software_connection = SoftwareConnection.create! valid_attributes
      get software_connection_url(software_connection)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_software_connection_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      software_connection = SoftwareConnection.create! valid_attributes
      get edit_software_connection_url(software_connection)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SoftwareConnection" do
        expect {
          post software_connections_url, params: { software_connection: valid_attributes }
        }.to change(SoftwareConnection, :count).by(1)
      end

      it "redirects to the created software_connection" do
        post software_connections_url, params: { software_connection: valid_attributes }
        expect(response).to redirect_to(software_connection_url(SoftwareConnection.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SoftwareConnection" do
        expect {
          post software_connections_url, params: { software_connection: invalid_attributes }
        }.to change(SoftwareConnection, :count).by(0)
      end

    
      it "renders a successful response (i.e. to display the 'new' template)" do
        post software_connections_url, params: { software_connection: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { 
          source_connector_id: srcconn.id,
          destination_connector_id: dstconn.id,
          ignore: true,
          ignore_reason: "not yet functional",
          description: "some text" 
        }
      end

      it "updates the requested software_connection" do
        software_connection = SoftwareConnection.create! valid_attributes
        patch software_connection_url(software_connection), params: { software_connection: new_attributes }
        software_connection.reload
        expect(software_connection.source_connector_id).to eq(srcconn.id)
        expect(software_connection.destination_connector_id).to eq(dstconn.id)
        expect(software_connection.ignore).to be_truthy
        expect(software_connection.ignore_reason).to eq("not yet functional")
        expect(software_connection.description.to_plain_text).to eq("some text")
      end

      it "redirects to the software_connection" do
        software_connection = SoftwareConnection.create! valid_attributes
        patch software_connection_url(software_connection), params: { software_connection: new_attributes }
        software_connection.reload
        expect(response).to redirect_to(software_connection_url(software_connection))
      end
    end

    context "with invalid parameters" do
    
      it "renders a successful response (i.e. to display the 'edit' template)" do
        software_connection = SoftwareConnection.create! valid_attributes
        patch software_connection_url(software_connection), params: { software_connection: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested software_connection" do
      software_connection = SoftwareConnection.create! valid_attributes
      expect {
        delete software_connection_url(software_connection)
      }.to change(SoftwareConnection, :count).by(-1)
    end

    it "redirects to the software_connections list" do
      software_connection = SoftwareConnection.create! valid_attributes
      delete software_connection_url(software_connection)
      expect(response).to redirect_to(software_connections_url)
    end
  end
end
