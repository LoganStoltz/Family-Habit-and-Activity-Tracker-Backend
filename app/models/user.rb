class User < ApplicationRecord
  has_secure_password
  has_many :profiles, dependent: :destroy
  validates :first_name, :last_name, :user_name, :email, presence: true
  validates :email, uniqueness: true
end
