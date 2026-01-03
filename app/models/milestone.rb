class Milestone < ApplicationRecord
  belongs_to :profile

  serialize :tags, coder: JSON

  validates :title, presence: true
  validates :occurred_at, presence: true
end
