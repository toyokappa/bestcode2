class Plan < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  accepts_nested_attributes_for :courses, allow_destroy: true
  enum state: { draft: 0, published: 1 }, _prefix: true

  validates :name, presence: true
  validates :courses, presence: { message: "を最低1件は登録してください" }
end
