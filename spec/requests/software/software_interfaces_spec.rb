require 'rails_helper'

RSpec.describe "Software::SoftwareInterfaces", type: :request do
  let(:software) { FactoryBot.create(:software) }
  let(:host) { FactoryBot.create(:host) }

  let(:valid_attributes) do
    FactoryBot.attributes_for(:software_interface, software_id: software.id, host_id: host.id)
  end

  let(:post_attributes) do
    FactoryBot.attributes_for(:software_interface, host_id: host.id)
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      SoftwareInterface.create! valid_attributes
      get software_software_interfaces_url(software)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      software_interface = SoftwareInterface.create! valid_attributes
      get software_software_interface_url(software, software_interface)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_software_software_interface_url(software)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      software_interface = SoftwareInterface.create! valid_attributes
      get edit_software_software_interface_url(software, software_interface)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SoftwareInterface" do
        expect {
          post software_software_interfaces_url(software), params: { software_interface: post_attributes }
        }.to change(SoftwareInterface, :count).by(1)
      end

      it "redirects to the created software_interface" do
        post software_software_interfaces_url(software), params: { software_interface: post_attributes }
        expect(response).to redirect_to(software_url(software))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SoftwareInterface" do
        expect {
          post software_software_interfaces_url(software), params: { software_interface: invalid_attributes }
        }.to change(SoftwareInterface, :count).by(0)
      end

    
      it "renders a successful response (i.e. to display the 'new' template)" do
        post software_software_interfaces_url(software), params: { software_interface: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { description: "a small description" }
      end

      it "updates the requested software_interface" do
        software_interface = SoftwareInterface.create! valid_attributes
        patch software_software_interface_url(software, software_interface), params: { software_interface: new_attributes }
        software_interface.reload
        expect(software_interface.description.to_plain_text).to eq('a small description')
      end

      it "redirects to the software_interface" do
        software_interface = SoftwareInterface.create! valid_attributes
        patch software_software_interface_url(software,software_interface), params: { software_interface: new_attributes }
        software_interface.reload
        expect(response).to redirect_to(software_url(software))
      end
    end

    context "with invalid parameters" do
    
      it "renders a successful response (i.e. to display the 'edit' template)" do
        software_interface = SoftwareInterface.create! valid_attributes
        patch software_software_interface_url(software,software_interface), params: { software_interface: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested software_interface" do
      software_interface = SoftwareInterface.create! valid_attributes
      expect {
        delete software_software_interface_url(software, software_interface)
      }.to change(SoftwareInterface, :count).by(-1)
    end

    it "redirects to the software_interfaces list" do
      software_interface = SoftwareInterface.create! valid_attributes
      delete software_software_interface_url(software, software_interface)
      expect(response).to redirect_to(software_url(software))
    end
  end
end
