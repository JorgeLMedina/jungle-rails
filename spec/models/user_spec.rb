require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should create a user with valid attributes' do
      expect(@user).to be_valid
    end

    it 'should not create a user with mismatched passwords' do
      @user.password_confirmation = 'different_password'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require first_name to be present' do
      @user.first_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should require last_name to be present' do
      @user.last_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should require email to be present' do
      @user.email = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should require email to be unique (case insensitive)' do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require password to have a minimum length of 6 characters' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'jane.doe@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should authenticate with valid credentials' do
      expect(User.authenticate_with_credentials('jane.doe@example.com', 'password')).to eq(@user)
    end

    it 'should not authenticate with invalid credentials' do
      expect(User.authenticate_with_credentials('jane.doe@example.com', 'wrongpassword')).to be false
    end

    it 'should authenticate with email having leading and trailing spaces' do
      expect(User.authenticate_with_credentials('  jane.doe@example.com  ', 'password')).to eq(@user)
    end

    it 'should authenticate with email in different case' do
      expect(User.authenticate_with_credentials('JANE.DOE@EXAMPLE.COM', 'password')).to eq(@user)
    end
  end
end

