# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notes/show', type: :view do
  let(:user) { FactoryBot.create(:user) }
  let!(:time) { Time.current }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'notes' }
    allow(controller).to receive(:action_name) { 'show' }
    @notable = FactoryBot.create(:server, name: 'xyzmirth')

    @note = assign(:note, FactoryBot.create(:note,
                                            notable: @notable,
                                            user_id: user.id,
                                            type: 'note',
                                            valid_until: '2024-01-01',
                                            created_at: time))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/#{time.localtime.to_fs(:local)}/)
    expect(rendered).to match(/xyzmirth/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2024-01-01/)
    expect(rendered).to match(/#{user}/)
    expect(rendered).to match(/note/)
  end
end
