require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  before(:each) do
    @channel_statistics = FactoryBot.create_list(:channel_statistic, 2)
  end

  it "renders start page" do
    render
    expect(rendered).to match(/Queued Messages/)
  end
end
