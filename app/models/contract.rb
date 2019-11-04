class Contract < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_one :proposer, through: :course, source: :owner

  enum state: {
    applying: 0,
    waiting_for_payment: 1,
    under_contract: 2,
    finished: 3,
    canceled: 4,
  }, _prefix: true

  validates :user_id, uniqueness: { scope: :course_id }, if: :has_alive_contracts?

  def self.has_any_alive?
    where(state: %i[applying waiting_for_payment under_contract]).present?
  end

  # 有効な契約が存在するかどうかの検証
  def has_alive_contracts?
    return false if state_finished? || state_canceled?

    contracts = self.class.where(user: user, course: course)
    contracts.has_any_alive?
  end
end
