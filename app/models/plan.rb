class Plan < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  accepts_nested_attributes_for :courses, allow_destroy: true
  enum state: { draft: 0, published: 1 }, _prefix: true

  validates :name, presence: true

  scope :search, ->(keyword = nil) do
    return all if keyword.blank? # キーワードが無ければ全件返す

    sql = <<~"SQL"
      plans.name LIKE :keyword OR
      plans.description LIKE :keyword OR
      courses.name LIKE :keyword OR
      courses.description LIKE :keyword
    SQL
    eager_load(:courses).
      where(sql, keyword: "%#{keyword}%").
      where(courses: { has_stopped: [false, nil] }) # nil -> コースが１件もない場合を考慮
  end
end
