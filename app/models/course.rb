class Course < ApplicationRecord
  belongs_to :plan
  has_many :contracts
  has_many :contracted_users, through: :contracts, source: :user
end
