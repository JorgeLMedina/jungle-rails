class User < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Enable password hashing and authentication
  has_secure_password
end
