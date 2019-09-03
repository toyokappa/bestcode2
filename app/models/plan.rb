class Plan < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy

  validates :name, presence: true

  enum state: { draft: 0, published: 1 }, _prefix: true
end
