require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) {
    { email: 'test123146@example.com', password: 'password123'}
  }

  let(:invalid_attributes) {
    { email: '', password: ''}
  }

  let(:user) { User.new(valid_attributes).save}

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      sign_in user
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      context 'equal names' do
        it "checks the user's email" do
          post :create, params: { user: valid_attributes }
          expect(User.last.email).to eq(valid_attributes[:user][:email])
        end
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(users_url(User.last))
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: 'New Name' }
      }

      it 'updates the requested user' do
        sign_in user
        patch :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.name).to eq('New Name')
      end

      it 'redirects to the user' do
        sign_in user
        patch :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it 'renders a response with 422 status' do
        sign_in user
        patch :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      sign_in user
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      sign_in user
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(users_url)
    end
  end
end
