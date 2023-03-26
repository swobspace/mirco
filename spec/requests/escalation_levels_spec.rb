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

RSpec.describe "/escalation_levels", type: :request do
  let(:cs) { FactoryBot.create(:channel_statistic) }
  let(:ng) { FactoryBot.create(:notification_group) }

  let(:valid_attributes) do
    FactoryBot.attributes_for(:escalation_level,
      escalatable_id: cs.id,
      escalatable_type: cs.class.name.to_s,
      attrib: 'last_message_received_at',
      notification_group_id: ng.id
    )
  end

  let(:invalid_attributes) do
    { attrib: nil }
  end

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      EscalationLevel.create! valid_attributes
      get escalation_levels_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      escalation_level = EscalationLevel.create! valid_attributes
      get escalation_level_url(escalation_level)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      escalation_level = EscalationLevel.create! valid_attributes
      get edit_escalation_level_url(escalation_level)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          max_warning: 5,
          max_critical: 10,
          min_warning: -10,
          min_critical: -20,
          show_on_dashboard: true,
          notification_group_id: ng.to_param,
          escalation_times_attributes: [
            start_time: '01:20',
            end_time: '08:40',
            weekdays: [3,4,7]
          ]
        }
      end

      it "updates the requested escalation_level" do
        escalation_level = EscalationLevel.create! valid_attributes
        patch escalation_level_url(escalation_level), params: { escalation_level: new_attributes }
        escalation_level.reload
        expect(escalation_level.min_warning).to eq(-10)
        expect(escalation_level.min_critical).to eq(-20)
        expect(escalation_level.max_warning).to eq(5)
        expect(escalation_level.max_critical).to eq(10)
        escalation_times = escalation_level.escalation_times
        expect(escalation_times.count).to eq(1)
        expect(escalation_times.first.start_time).to eq('01:20')
        expect(escalation_times.first.end_time).to eq('08:40')
        expect(escalation_times.first.weekdays).to contain_exactly(3,4,7)
      end

      it "redirects to the escalation_level" do
        escalation_level = EscalationLevel.create! valid_attributes
        patch escalation_level_url(escalation_level), params: { escalation_level: new_attributes }
        escalation_level.reload
        expect(response).to redirect_to(escalation_level_url(escalation_level))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        escalation_level = EscalationLevel.create! valid_attributes
        patch escalation_level_url(escalation_level), params: { escalation_level: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested escalation_level" do
      escalation_level = EscalationLevel.create! valid_attributes
      expect {
        delete escalation_level_url(escalation_level)
      }.to change(EscalationLevel, :count).by(-1)
    end

    it "redirects to the escalation_levels list" do
      escalation_level = EscalationLevel.create! valid_attributes
      delete escalation_level_url(escalation_level)
      expect(response).to redirect_to(escalation_levels_url)
    end
  end
end
