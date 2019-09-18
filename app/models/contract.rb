class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum state: {
    applying: 0,
    waiting_for_payment: 1,
    under_contract: 2,
    finished: 3,
    canceled: 4,
  }, _prefix: true

  validates :user_id, uniqueness: { scope: :course_id }, if: :has_alive_contracts?

  # 有効な契約が存在するかどうかの検証
  def has_alive_contracts?
    contracts = self.class.where(user: user, course: course)
    contracts.any? { |c| c.state_applying? || c.state_waiting_for_payment? || c.state_under_contract? }
  end
end
