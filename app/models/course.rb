class Course < ApplicationRecord
  before_destroy :protect_contracted_course

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
  validates :fee, presence: true, numericality: { greater_than_or_equal_to: 1000, allow_blank: true, message: "は1000円以上で設定してください" }

  private

    def protect_contracted_course
      if contracts.has_any_alive?
        errors[:base] << "契約中のユーザーが存在する場合、コースを削除できません"
        throw :abort
      end
    end
end
