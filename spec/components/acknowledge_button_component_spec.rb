# frozen_string_literal: true

require "rails_helper"

RSpec.describe AcknowledgeButtonComponent, type: :component do
  include Rails.application.routes.url_helpers
  let(:user) { FactoryBot.create(:user) }

  describe "Server" do
    let!(:server) { FactoryBot.create(:server) }

    describe "with acknowledge" do
      let!(:ack) { server.acknowledges.create!(user_id: user.id, message: "An acknowledge") }
      before(:each) do
        expect(server).to receive(:condition).at_least(:once).and_return(Mirco::States::WARNING)
        server.update(acknowledge_id: ack.id)
        server.reload
      end

      it "shows read button" do
        render_inline(described_class.new(notable: server, readonly: true))
        expect(page).to have_css('a[class="btn btn-sm btn-outline-secondary"]')
        expect(page).to have_css(%Q[a[href="#{server_note_path(server, ack)}"]])
      end
    end

    describe "without acknowledge" do
      describe "in error state" do
        before(:each) do
          expect(server).to receive(:condition).and_return(Mirco::States::WARNING)
        end

        it "shows ack button" do
          render_inline(described_class.new(notable: server, readonly: false))
          expect(page).to have_css('a[class="btn btn-sm btn-warning"]')
          expect(page).to have_css(%Q[a[href="#{new_server_note_path(server, type: 'acknowledge')}"]])
        end
      end

      describe "state ok or nothing" do
        before(:each) do
          expect(server).to receive(:condition).and_return(Mirco::States::OK)
        end

        it "does not shows ack button" do
          render_inline(described_class.new(notable: server, readonly: false))
          expect(page).not_to have_css('a[class="btn btn-sm btn-warning"]')
          expect(page).not_to have_css(%Q[a[href="#{new_server_note_path(server, type: 'acknowledge')}"]])
        end
      end

      it "readonly - does not show ack button" do
        render_inline(described_class.new(notable: server))
        expect(page).not_to have_css('a[class="btn btn-sm btn-warning"]')
        expect(page).not_to have_css(%Q[a[href="#{new_server_note_path(server, type: 'acknowledge')}"]])
      end
    end
  end
end
