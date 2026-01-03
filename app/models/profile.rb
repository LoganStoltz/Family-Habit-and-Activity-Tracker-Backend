class Profile < ApplicationRecord
  belongs_to :user
  has_many :habits, dependent: :destroy
  has_many :milestones, dependent: :destroy
end
