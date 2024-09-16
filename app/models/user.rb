class User < ApplicationRecord
  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  # Enable password hashing and authentication
  has_secure_password

  # Class method to authenticate user with credentials
  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by('lower(email) = ?', email)
    user && user.authenticate(password)
  end
end
