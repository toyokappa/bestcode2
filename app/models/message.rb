class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  scope :exchange_between, ->(user, another_user) {
    massagers = [user, another_user]
    where(sender: massagers, receiver: massagers)
  }

  delegate :name, to: :sender, prefix: :sender
  validates :body, presence: true, length: { maximum: 5000, allow_nil: true }

  # FIXME: Decoratorを入れる際に移したい
  def formated_created_at
    case created_at
    when Date.today.all_day
      created_at.strftime("%H:%M")
    when Date.yesterday.all_day
      "昨日"
    when 7.days.ago.beginning_of_day..2.days.ago.end_of_day
      days = (Date.today - created_at.to_date).to_i
      "#{days}日前"
    else
      created_at.strftime("%Y/%m/%d")
    end
  end
end
