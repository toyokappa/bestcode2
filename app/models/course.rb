class Course < ApplicationRecord
  belongs_to :plan
  has_many :contracts, dependent: :nullify
  has_many :contracted_users, through: :contracts, source: :user

  # 契約中のコース一覧を返す
  scope :with_alive_contracts, -> {
    eager_load(:contracts).where.not(contracts: { state: [:finished, :canceled] })
  }
end
