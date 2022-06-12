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

RSpec.describe "/hosts", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Host. As you add validations to Host, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Host.create! valid_attributes
      get hosts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      host = Host.create! valid_attributes
      get host_url(host)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_host_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      host = Host.create! valid_attributes
      get edit_host_url(host)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Host" do
        expect {
          post hosts_url, params: { host: valid_attributes }
        }.to change(Host, :count).by(1)
      end

      it "redirects to the created host" do
        post hosts_url, params: { host: valid_attributes }
        expect(response).to redirect_to(host_url(Host.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Host" do
        expect {
          post hosts_url, params: { host: invalid_attributes }
        }.to change(Host, :count).by(0)
      end

    
      it "renders a successful response (i.e. to display the 'new' template)" do
        post hosts_url, params: { host: invalid_attributes }
        expect(response).to be_successful
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested host" do
        host = Host.create! valid_attributes
        patch host_url(host), params: { host: new_attributes }
        host.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the host" do
        host = Host.create! valid_attributes
        patch host_url(host), params: { host: new_attributes }
        host.reload
        expect(response).to redirect_to(host_url(host))
      end
    end

    context "with invalid parameters" do
    
      it "renders a successful response (i.e. to display the 'edit' template)" do
        host = Host.create! valid_attributes
        patch host_url(host), params: { host: invalid_attributes }
        expect(response).to be_successful
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested host" do
      host = Host.create! valid_attributes
      expect {
        delete host_url(host)
      }.to change(Host, :count).by(-1)
    end

    it "redirects to the hosts list" do
      host = Host.create! valid_attributes
      delete host_url(host)
      expect(response).to redirect_to(hosts_url)
    end
  end
end
