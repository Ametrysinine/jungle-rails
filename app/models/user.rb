class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: {minimum: 7}
  validates :password_confirmation, presence: true
  validates :password_digest, presence: true
  has_secure_password

  def self.authenticate_with_credentials(params)
    user = User.find_by(email: params[:email].strip.downcase)
    if user && user.authenticate(params[:password])
      return user
    else
      return nil
    end
  end
end
