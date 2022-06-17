# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'servers/show', type: :view do
  let(:location) { FactoryBot.create(:location, lid: 'LLX', name: 'Koka') }
  let(:host) do
     FactoryBot.create(:host, 
       name: 'BND03x', 
       ipaddress: '4.5.6.7',
       location: location
     )
  end
  let(:time_now) { Time.current }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'servers' }
    allow(controller).to receive(:action_name) { 'edit' }

    current_user = FactoryBot.create(:user, sn: 'Mustermann', givenname: 'Max')
    allow(controller).to receive(:current_user) { current_user }
    allow(current_user).to receive(:is_admin?).and_return(true)

    @server = assign(:server, Server.create!(
                                name: 'MyServer',
                                uid: '04170347-f80c-441d-81e6-c963ff80a984',
                                host: host,
                                description: 'MyText',
                                api_url: 'Api Url',
                                api_user: 'Api User',
                                api_password: 'MyText',
                                api_user_has_full_access: false,
                                properties: {},
                                last_check: time_now,
                                last_check_ok: time_now
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyServer/)
    expect(rendered).to match(/04170347-f80c-441d-81e6-c963ff80a984/)
    expect(rendered).to match(/LLX: Koka/)
    expect(rendered).to match(/BND03x \(4.5.6.7\)/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Api Url/)
    expect(rendered).to match(/Api User/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(time_now.to_s.gsub(/\+\d{4}/, '').to_s)
  end
end
