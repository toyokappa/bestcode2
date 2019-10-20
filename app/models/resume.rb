class Resume < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  # TODO: 開始日と終了日の順序のバリデーションを追加
end
