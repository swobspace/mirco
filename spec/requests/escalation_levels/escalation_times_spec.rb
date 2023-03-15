require 'rails_helper'

module EscalationLevels
  RSpec.describe "EscalationTimes", type: :request do
    let(:el) { FactoryBot.create(:escalation_level, attrib: 'queued') }

    let(:valid_attributes) do
      FactoryBot.attributes_for(:escalation_time, 
        escalation_level_id: el.id
      )
    end

    let(:invalid_attributes) {
      { weekdays: [] }
    }

    before(:each) do
      login_admin
    end

    describe "GET /index" do
      it "renders a successful response" do
        EscalationTime.create! valid_attributes
        get escalation_level_escalation_times_url(el)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        escalation_time = EscalationTime.create! valid_attributes
        get escalation_level_escalation_time_url(el, escalation_time)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_escalation_level_escalation_time_url(el)
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        escalation_time = EscalationTime.create! valid_attributes
        get edit_escalation_level_escalation_time_url(el, escalation_time)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new EscalationTime" do
          expect {
            post escalation_level_escalation_times_url(el), 
                   params: { escalation_time: valid_attributes }
          }.to change(EscalationTime, :count).by(1)
        end

        it "redirects to the created escalation_time" do
          post escalation_level_escalation_times_url(el), 
                 params: { escalation_time: valid_attributes }
          expect(response).to redirect_to(escalation_level_url(el))
        end
      end

      context "with invalid parameters" do
        it "does not create a new EscalationTime" do
          expect {
            post escalation_level_escalation_times_url(el),
                   params: { escalation_time: invalid_attributes }
          }.to change(EscalationTime, :count).by(0)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post escalation_level_escalation_times_url(el), 
                 params: { escalation_time: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) do
          { weekdays: [0,1,2,3,5,18,nil], start_time: '09:00', end_time: '13:30' }
        end

        it "updates the requested escalation_time" do
          escalation_time = EscalationTime.create! valid_attributes
          patch escalation_level_escalation_time_url(el, escalation_time), 
                  params: { escalation_time: new_attributes }
          escalation_time.reload
          expect(escalation_time.weekdays).to contain_exactly(1,2,3,5)
          expect(escalation_time.start_time.to_fs(:time)).to eq("09:00")
          expect(escalation_time.end_time.to_fs(:time)).to eq("13:30")
        end

        it "redirects to the escalation_time" do
          escalation_time = EscalationTime.create! valid_attributes
          patch escalation_level_escalation_time_url(el,escalation_time), 
                  params: { escalation_time: new_attributes }
          escalation_time.reload
          expect(response).to redirect_to(escalation_level_url(el))
        end
      end

      context "with invalid parameters" do
      
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          escalation_time = EscalationTime.create! valid_attributes
          patch escalation_level_escalation_time_url(el, escalation_time), 
                  params: { escalation_time: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested escalation_time" do
        escalation_time = EscalationTime.create! valid_attributes
        expect {
          delete escalation_level_escalation_time_url(el,escalation_time)
        }.to change(EscalationTime, :count).by(-1)
      end

      it "redirects to the escalation_times list" do
        escalation_time = EscalationTime.create! valid_attributes
        delete escalation_level_escalation_time_url(el,escalation_time)
        expect(response).to redirect_to(escalation_level_url(el))
      end
    end
  end
end
