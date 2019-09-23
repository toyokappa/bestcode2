class User < ApplicationRecord
  has_one :plan, dependent: :destroy
  has_many :mentee_contracts, dependent: :nullify, class_name: "Contract"
  has_many :own_courses, through: :plan, source: :courses
  has_many :contracted_courses, through: :mentee_contracts, source: :course
  has_many :mentor_contracts, through: :own_courses, source: :contracts
  has_many :mentees, -> { distinct }, through: :mentor_contracts, source: :user
  has_many :mentors, -> { distinct }, through: :mentee_contracts, source: :proposer

  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  class << self
    def find_or_create_by_omniauth(auth)
      user = find_by(provider: auth.provider, uid: auth.uid)
      if user
        user.update!(access_token: auth.credentials.token)
        user
      else
        create!(
          provider: auth.provider,
          uid: auth.uid,
          name: auth.info.nickname,
          display_name: auth.info.name,
          email: auth.info.email,
          remote_image_url: auth.info.image,
          access_token: auth.credentials.token,
        )
      end
    end
  end

  def contracting?(course_id)
    contracted_courses.with_alive_contracts.exists?(course_id)
  end
end
