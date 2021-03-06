class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  scope :exchange_between, ->(user, another_user) {
    massagers = [user, another_user]
    where(sender: massagers, receiver: massagers)
  }

  delegate :name, to: :sender, prefix: :sender
  validates :body, presence: true, length: { maximum: 5000, allow_nil: true }
end
