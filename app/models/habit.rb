class Habit < ApplicationRecord
  belongs_to :profile
  has_many :habit_logs, dependent: :destroy
end
