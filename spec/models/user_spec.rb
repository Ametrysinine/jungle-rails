require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "asdf1234",
        password_confirmation: "asdf1234"
      )
      expect(user).to be_valid
    end
    it "is invalid with a password shorter than length 7" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "123456",
        password_confirmation: "123456"
      )
      user.save
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end
    it "is invalid with a non-matching password" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "12345678",
        password_confirmation: "123456789"
      )
      user.save
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "is invalid with two identical emails" do
      user1 = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "1234567",
        password_confirmation: "1234567"
      )
      user1.save

      user2 = User.new(
        username: "mandaa",
        email: "AMAnda@gmail.com",
        first_name: "Joe",
        last_name: "Snyder",
        password: "1234567",
        password_confirmation: "1234567"
      )
      user2.save
      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
    it "authenticates correct passwords" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "12345678",
        password_confirmation: "12345678"
      )
      expect(user.authenticate("12345678")).to be_valid
    end
    it "doesn't authenticate incorrect passwords" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "12345678",
        password_confirmation: "12345678"
      )
      expect(user.authenticate("123456789")).to be_falsey
    end
    
  end
  describe '.authenticate_with_credentials' do
    it "should authenticate valid passwords" do
      user = User.new(
        username: "amanda",
        email: "amanda@gmail.com",
        first_name: "Amanda",
        last_name: "Banks",
        password: "12345678",
        password_confirmation: "12345678"
      )
      user.save
      expect(User.authenticate_with_credentials(email: "amanda@gmail.com", password: "12345678", password_confirmation: "12345678")).to eq(user)
    end

  end
end
