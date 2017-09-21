class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'is not valid' }
  validates_length_of :password, minimum: 8
  validates_length_of :name, minimum: 3
end
