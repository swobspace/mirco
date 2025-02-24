# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/servers', type: :request do
  let(:location) { FactoryBot.create(:location, lid: 'LLX') }
  let(:host) { FactoryBot.create(:host, location: location) }
  # Server. As you add validations to Server, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    FactoryBot.attributes_for(:server, host_id: host.id)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before(:each) do
    login_admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Server.create! valid_attributes
      get servers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /index/sindex' do
    it 'renders a successful response' do
      Server.create! valid_attributes
      get sindex_servers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      server = Server.create! valid_attributes
      get server_url(server)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_server_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      server = Server.create! valid_attributes
      get edit_server_url(server)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Server' do
        expect do
          post servers_url, params: { server: valid_attributes }
        end.to change(Server, :count).by(1)
      end

      it 'redirects to the created server' do
        post servers_url, params: { server: valid_attributes }
        expect(response).to redirect_to(server_url(Server.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Server' do
        expect do
          post servers_url, params: { server: invalid_attributes }
        end.to change(Server, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post servers_url, params: { server: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PATCH /update_properties' do
    let(:server) do
      FactoryBot.create(:server,
                        api_url: ENV['API_URL'],
                        api_user: ENV['API_USER'],
                        api_password: ENV['API_PASSWORD'],
                        api_verify_ssl: ENV['API_VERIFY_SSL'])
    end
    it 'redirects to server' do
      post update_properties_server_url(server)
      expect(response).to redirect_to(server_url(server))
    end
    it 'updates server properties' do
      post update_properties_server_url(server)
      server.reload
      expect(server.properties['server_uid']).to be_present
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          uid: 'db5fd489-9335-4d31-adba-d7891bfe5433',
          description: 'A short description',
          api_url: 'https://localhost:8443/api',
          api_user: 'dummy',
          api_user_has_full_access: false,
          api_verify_ssl: true,
          manual_update: true,
          disabled: true
        }
      end

      it 'updates the requested server' do
        server = Server.create! valid_attributes
        patch server_url(server), params: { server: new_attributes }
        server.reload
        expect(server.attributes.symbolize_keys).to include(new_attributes)
      end

      it 'redirects to the server' do
        server = Server.create! valid_attributes
        patch server_url(server), params: { server: new_attributes }
        server.reload
        expect(response).to redirect_to(server_url(server))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        server = Server.create! valid_attributes
        patch server_url(server), params: { server: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested server' do
      server = Server.create! valid_attributes
      expect do
        delete server_url(server)
      end.to change(Server, :count).by(-1)
    end

    it 'redirects to the servers list' do
      server = Server.create! valid_attributes
      delete server_url(server)
      expect(response).to redirect_to(servers_url)
    end
  end
end
