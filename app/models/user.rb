class User < ApplicationRecord
  has_secure_password
  has_many :profiles
  validates :first_name, :last_name, :user_name, :email, presence: true
  validates :email, uniqueness: true
end
