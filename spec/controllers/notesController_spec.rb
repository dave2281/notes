require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  # Заменяем Devise::TestHelpers на Devise::Test::ControllerHelpers
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { attributes_for(:note) }

      it 'creates a new note' do
        expect {
          post :create, params: { note: valid_attributes }
        }.to change(Note, :count).by(1)
      end

      it 'redirects to the home index path' do
        post :create, params: { note: valid_attributes }
        expect(response).to redirect_to(home_index_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '', text: '' } }

      it 'does not create a new note' do
        expect {
          post :create, params: { note: invalid_attributes }
        }.not_to change(Note, :count)
      end

      it 'redirects to the new note path' do
        post :create, params: { note: invalid_attributes }
        expect(response).to redirect_to(new_note_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { title: 'Updated Title' } }

      it 'updates the requested note' do
        patch :update, params: { id: note.id, note: new_attributes }
        note.reload
        expect(note.title).to eq('Updated Title')
      end

      it 'redirects to the home index path' do
        patch :update, params: { id: note.id, note: new_attributes }
        expect(response).to redirect_to(home_index_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '' } }

      it 'does not update the requested note' do
        patch :update, params: { id: note.id, note: invalid_attributes }
        note.reload
        expect(note.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: note.id, note: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested note' do
      note
      expect {
        delete :destroy, params: { id: note.id }
      }.to change(Note, :count).by(-1)
    end

    it 'redirects to the home index path' do
      delete :destroy, params: { id: note.id }
      expect(response).to redirect_to(home_index_path)
    end
  end
end
