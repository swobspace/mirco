require 'rails_helper'

module InterfaceConnectors
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

    describe "GET /index" do
      it "renders a successful response" do
        SoftwareConnection.create! valid_attributes
        get interface_connector_software_connections_url(srcconn)
        expect(response).to be_successful
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
          patch interface_connector_software_connection_url(srcconn, software_connection), params: { software_connection: new_attributes }
          software_connection.reload
          expect(software_connection.source_connector_id).to eq(srcconn.id)
          expect(software_connection.destination_connector_id).to eq(dstconn.id)
          expect(software_connection.ignore).to be_truthy
          expect(software_connection.ignore_reason).to eq("not yet functional")
          expect(software_connection.description.to_plain_text).to eq("some text")
        end

        it "redirects to the software_connection" do
          software_connection = SoftwareConnection.create! valid_attributes
          patch interface_connector_software_connection_url(srcconn, software_connection), params: { software_connection: new_attributes }
          software_connection.reload
          expect(response).to redirect_to(software_connection_url(software_connection))
        end
      end

      context "with invalid parameters" do
      
        it "renders a successful response (i.e. to display the 'edit' template)" do
          software_connection = SoftwareConnection.create! valid_attributes
          patch interface_connector_software_connection_url(srcconn,software_connection), params: { software_connection: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      
      end
    end

  end
end
