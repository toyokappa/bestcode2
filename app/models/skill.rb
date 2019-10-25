class Skill < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :level, presence: true
  validates :experience, presence: true

  enum level: {
    beginner: 1,
    novice: 2,
    middle: 3,
    expert: 4,
    master: 5,
  }, _prefix: true

  enum experience: {
    under_half_year: 1,
    under_1_year: 2,
    under_3_years: 3,
    under_5_years: 4,
    over_5_years: 5,
  }, _prefix: true
end
