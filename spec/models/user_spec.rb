require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, username: 'John Doe', email: 'john1@gmail.com', password: 'password') }

  describe 'user data-variables validation' do
    context 'invalid data' do
      it 'invalid email' do
        user.email = nil
        expect(user).not_to be_valid
      end

      it 'nil password' do
        user.password = nil
        expect(user).not_to be_valid
      end

      it 'invalid password length' do
        user.password = '123'
        expect(user).not_to be_valid
      end
    end
  end
end
