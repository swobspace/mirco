# frozen_string_literal: true

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

module Servers
  RSpec.describe 'Notes', type: :request do
    let!(:server) { FactoryBot.create(:server, name: 'MyServer') }
    let!(:user) { FactoryBot.create(:user) }

    let(:valid_attributes) do
      {
        notable_id: server.id,
        notable_type: 'Server',
        type: 'acknowledge',
        message: 'some special stuff',
        user_id: user.id
      }
    end

    let(:post_attributes) do
      {
        server_id: server.id,
        message: 'some special stuff'
      }
    end

    let(:invalid_attributes) do
      {
        message: nil
      }
    end

    before(:each) do
      login_admin
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        Note.create! valid_attributes
        get server_notes_url(server)
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        note = Note.create! valid_attributes
        get server_note_url(server, note)
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_server_note_url(server)
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'render a successful response' do
        note = Note.create! valid_attributes
        get edit_server_note_url(server, note)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Note' do
          expect do
            post server_notes_url(server), params: { note: post_attributes }
          end.to change(Note, :count).by(1)
        end

        it 'redirects to the created note' do
          post server_notes_url(server), params: { note: post_attributes }
          expect(response).to redirect_to(server_url(server, anchor: 'notes'))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Note' do
          expect do
            post server_notes_url(server), params: { note: invalid_attributes }
          end.to change(Note, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post server_notes_url(server), params: { note: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            message: 'some other text',
            valid_until: 1.day.after(Time.current)
          }
        end

        it 'updates the requested note' do
          note = Note.create! valid_attributes
          patch server_note_url(server, note), params: { note: new_attributes }
          note.reload
          expect(note.message.to_plain_text).to eq('some other text')
          expect(note.valid_until.to_date.to_s).to eq(1.day.after(Date.current).to_s)
        end

        it 'redirects to the note' do
          note = Note.create! valid_attributes
          patch server_note_url(server, note), params: { note: new_attributes }
          note.reload
          expect(response).to redirect_to(server_url(server, anchor: 'notes'))
        end
      end

      context 'with invalid parameters' do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          note = Note.create! valid_attributes
          patch server_note_url(server, note), params: { note: invalid_attributes }
          expect(response).to have_http_status(422)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested note' do
        note = Note.create! valid_attributes
        expect do
          delete server_note_url(server, note)
        end.to change(Note, :count).by(-1)
      end

      it 'redirects to the notes list' do
        note = Note.create! valid_attributes
        delete server_note_url(server, note)
        expect(response).to redirect_to(server_url(server, anchor: 'notes'))
      end
    end
  end
end
