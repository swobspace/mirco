# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConditionIconComponent, type: :component do
  let(:server) { FactoryBot.create(:server) }

  describe "with condition = CRITICAL" do
    it "shows CRITICAL button" do
      expect(server).to receive(:condition).at_least(:once)
                                              .and_return(Mirco::States::CRITICAL)
      render_inline(described_class.new(item: server))
      expect(page).to have_css('button[class="btn btn-danger"]')
    end
  end

  describe "with condition = WARNING" do
    it "shows WARNING button" do
      expect(server).to receive(:condition).at_least(:once)
                                              .and_return(Mirco::States::WARNING)
      render_inline(described_class.new(item: server))
      expect(page).to have_css('button[class="btn btn-warning"]')
    end
  end

  describe "with condition = OK" do
    it "shows OK button" do
      expect(server).to receive(:condition).at_least(:once)
                                              .and_return(Mirco::States::OK)
      render_inline(described_class.new(item: server))
      expect(page).to have_css('button[class="btn btn-success"]')
    end
  end

  describe "with condition = UNKNOWN" do
    it "shows UNKNOWN button" do
      expect(server).to receive(:condition).at_least(:once)
                                              .and_return(Mirco::States::UNKNOWN)
      render_inline(described_class.new(item: server))
      expect(page).to have_css('button[class="btn btn-info"]')
    end
  end
end
