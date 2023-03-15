require 'rails_helper'

module ChannelStatistics
  RSpec.describe "EscalationLevels", type: :request do
    let(:cs) { FactoryBot.create(:channel_statistic) } 
    let(:ng) { FactoryBot.create(:notification_group) }
   
    let(:valid_attributes) do
      FactoryBot.attributes_for(:escalation_level, 
        escalatable_id: cs.id, 
        escalatable_type: 'ChannelStatistic',
        notification_group_id: ng.id,
        attrib: 'last_message_received_at'
      )
    end

    let(:post_attributes) do
        { attrib: 'last_message_received_at' }
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
        get channel_statistic_escalation_levels_url(cs)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        escalation_level = EscalationLevel.create! valid_attributes
        get channel_statistic_escalation_level_url(cs, escalation_level)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_channel_statistic_escalation_level_url(cs)
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        escalation_level = EscalationLevel.create! valid_attributes
        get edit_channel_statistic_escalation_level_url(cs,escalation_level)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new EscalationLevel" do
          expect {
            post channel_statistic_escalation_levels_url(cs), params: { escalation_level: valid_attributes }
          }.to change(EscalationLevel, :count).by(1)
        end

        it "redirects to the created escalation_level" do
          post channel_statistic_escalation_levels_url(cs), params: { escalation_level: valid_attributes }
          expect(response).to redirect_to(channel_statistic_escalation_level_url(cs, EscalationLevel.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new EscalationLevel" do
          expect {
            post channel_statistic_escalation_levels_url(cs), params: { escalation_level: invalid_attributes }
          }.to change(EscalationLevel, :count).by(0)
        end

      
        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post channel_statistic_escalation_levels_url(cs), params: { escalation_level: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          { max_warning: 5, max_critical: 10, min_warning: -10, min_critical: -20 }
        }

        it "updates the requested escalation_level" do
          escalation_level = EscalationLevel.create! valid_attributes
          patch channel_statistic_escalation_level_url(cs, escalation_level), params: { escalation_level: new_attributes }
          escalation_level.reload
          expect(escalation_level.min_warning).to eq(-10)
          expect(escalation_level.min_critical).to eq(-20)
          expect(escalation_level.max_warning).to eq(5)
          expect(escalation_level.max_critical).to eq(10)
        end

        it "redirects to the escalation_level" do
          escalation_level = EscalationLevel.create! valid_attributes
          patch channel_statistic_escalation_level_url(cs,escalation_level), params: { escalation_level: new_attributes }
          escalation_level.reload
          expect(response).to redirect_to(channel_statistic_escalation_level_url(cs,EscalationLevel.last))
        end
      end

      context "with invalid parameters" do
      
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          escalation_level = EscalationLevel.create! valid_attributes
          patch channel_statistic_escalation_level_url(cs,escalation_level), params: { escalation_level: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested escalation_level" do
        escalation_level = EscalationLevel.create! valid_attributes
        expect {
          delete channel_statistic_escalation_level_url(cs,escalation_level)
        }.to change(EscalationLevel, :count).by(-1)
      end

      it "redirects to the escalation_levels list" do
        escalation_level = EscalationLevel.create! valid_attributes
        delete channel_statistic_escalation_level_url(cs,escalation_level)
        expect(response).to redirect_to(channel_statistic_url(cs))
      end
    end
  end
end
