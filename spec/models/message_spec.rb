require "rails_helper"

RSpec.describe Message, type: :model do
  describe "validation" do
    it "bodyは必須である" do
      message = build(:message, body: nil)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end

    it "bodyの入力上限は5000文字である" do
      message = build(:message, body: "a" * 5001)
      message.valid?
      expect(message.errors[:body]).to include("は5000文字以内で入力してください")
    end
  end

  describe ".exchange_between" do
    let(:sender) { create :user }
    let(:receiver) { create :user }
    let(:other_sender) { create :user }
    let(:other_receiver) { create :user }

    before do
      create :message, sender: sender, receiver: receiver, body: "this is correct message"
      create :message, sender: sender, receiver: other_receiver, body: "this is wrong message with other receiver"
      create :message, sender: other_sender, receiver: receiver, body: "this is wrong message with other sender"
      create :message, sender: other_sender, receiver: other_receiver, body: "this is wrong message with other sender and receiver"
    end

    it "該当のメッセージを抽出できる" do
      messages = Message.exchange_between(sender, receiver)
      expect(messages.count).to eq 1
      expect(messages.first.body).to eq "this is correct message"
    end
  end
end
