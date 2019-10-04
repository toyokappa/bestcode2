class User < ApplicationRecord
  has_one :plan, dependent: :destroy
  has_many :mentee_contracts, dependent: :nullify, class_name: "Contract"
  has_many :own_courses, through: :plan, source: :courses
  has_many :contracted_courses, through: :mentee_contracts, source: :course
  has_many :mentor_contracts, through: :own_courses, source: :contracts
  has_many :mentees, -> { distinct }, through: :mentor_contracts, source: :user
  has_many :mentors, -> { distinct }, through: :mentee_contracts, source: :proposer
  has_many :sent_messages, dependent: :nullify, class_name: "Message", foreign_key: :sender_id, inverse_of: :sender
  has_many :received_messages, dependent: :nullify, class_name: "Message", foreign_key: :receiver_id, inverse_of: :receiver
  has_many :message_sender, -> { distinct }, through: :received_messages, source: :sender
  has_many :message_receiver, -> { distinct }, through: :sent_messages, source: :receiver

  scope :with_alive_contracts, ->(user_type: :mentee) {
    alive_state = [0, 1, 2] # applying, waiting_for_payment, under_contract
    load_key = "#{user_type}_contracts"
    eager_load(load_key).where(contracts: { state: alive_state })
  }

  mount_uploader :image, ImageUploader

  delegate :name, to: :plan, prefix: :plan

  URL_FMT = /\A#{URI::regexp(%w[http https])}\z/
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :display_name, presence: true
  validates :url, format: { with: URL_FMT, allow_blank: true }

  def to_param
    name
  end

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

  def messaging_user
    (message_sender + message_receiver).uniq
  end

  def latest_message
    (sent_messages + received_messages).max_by(&:created_at)
  end
end
