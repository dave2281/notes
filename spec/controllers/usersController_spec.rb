require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:valid_attributes) {
    { name: "Test User", username: "testuser", email: "test@example.com", password: "password123"}
  }

  let(:invalid_attributes) {
    { name: "", username: ''}
  }

  let(:user) { User.create!(valid_attributes) }

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      sign_in user
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

=begin
  describe "POST #create" do
    context "with valid params" do
      it "creates a user and returns the user's details" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/users", params: { user: { email: "john@example.org", password: '123123', password_confirmation: '123123' } }

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end
      it "creates a successful mesaage post" do
        @user = User.create(email: 'test@mail.com', password: '123123')
        expect(@user).to be_an_instance_of User
      end

      it "redirects to the created user" do
        allow(controller).to receive(:verify_recaptcha).and_return(true) # Мокирование успешной проверки reCAPTCHA

        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end
=end

    context "with invalid params" do
      it "renders a response with 422 status" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "New Name" }
      }

      it "updates the requested user" do
        sign_in user
        patch :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.name).to eq("New Name")
      end

      it "redirects to the user" do
        sign_in user
        patch :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      it "renders a response with 422 status" do
        sign_in user
        patch :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      sign_in user
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      sign_in user
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(users_url)
    end
  end
end
