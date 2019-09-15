class Plan < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  enum state: { draft: 0, published: 1 }, _prefix: true
end
