class Plan < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy
  enum state: { draft: 0, published: 1 }, _prefix: true
end
