class User < ApplicationRecord
  has_one :plan, dependent: :destroy
  has_many :contracts, dependent: :nullify
  has_many :contracted_courses, through: :contracts, source: :course

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
