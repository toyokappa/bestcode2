class Course < ApplicationRecord
  belongs_to :plan
  has_many :contracts, dependent: :nullify
  has_many :contracted_users, through: :contracts, source: :user
  has_one :owner, through: :plan, source: :user

  # 契約中のコース一覧を返す
  scope :with_alive_contracts, -> {
    alive_state = %i[applying waiting_for_payment under_contract]
    eager_load(:contracts).where(contracts: { state: alive_state })
  }

  validates :name, presence: true
end
