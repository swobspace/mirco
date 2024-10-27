# frozen_string_literal: true

require 'rails_helper'

module Servers
  RSpec.describe 'notes/index', type: :view do
    let!(:ts)  { Time.current }
    let(:user) { FactoryBot.create(:user) }
    let!(:time) { Time.current }
    before(:each) do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      allow(controller).to receive(:current_ability) { @ability }
      allow(controller).to receive(:controller_name) { 'notes' }
      allow(controller).to receive(:action_name) { 'index' }
      @notable = FactoryBot.create(:server, name: 'xyzmirth')

      # @note = assign(:note, FactoryBot.create(:note, server_id: @notable.id))

      assign(:notes, [
               FactoryBot.create(:note,
                                 notable: @notable,
                                 user: user,
                                 type: 'note',
                                 message: 'some text',
                                 created_at: time),
               FactoryBot.create(:note,
                                 notable: @notable,
                                 user: user,
                                 type: 'note',
                                 message: 'some text',
                                 valid_until: '2024-01-01',
                                 created_at: time)
             ])
    end

    it 'renders a list of notes' do
      render
      assert_select 'tr>td', text: time.localtime.to_fs(:local), count: 2
      assert_select 'tr>td', text: nil.to_s, count: 3
      assert_select 'tr>td', text: user.to_s, count: 2
      assert_select 'tr>td', text: 'Notiz'.to_s, count: 2
      assert_select 'tr>td', text: 'some text'.to_s, count: 2
      assert_select 'tr>td', text: Regexp.new('2024-01-01'.to_s), count: 1

    end
  end
end
