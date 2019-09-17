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
end
