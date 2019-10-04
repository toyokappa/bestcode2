require "rails_helper"

RSpec.describe "MessageExchange", type: :system do
  let(:sender) { create :user }
  let(:receiver) { create :user }

  describe "ページアクセス" do
    context "他のユーザーとのメッセージページへアクセスした場合" do
      before do
        sign_in sender
        visit users_messages_path(receiver)
      end

      it "メッセージページへ遷移する" do
        expect(current_path).to eq users_messages_path(receiver)
      end
    end

    context "自分のメッセージページへアクセスした場合" do
      before do
        sign_in sender
        visit users_messages_path(sender)
      end

      it "メッセージボックスページへリダイレクトされる" do
        expect(current_path).to eq users_message_box_path
      end
    end
  end

  describe "メッセージ投稿" do
    before do
      sign_in sender
      visit users_messages_path(receiver)
      fill_in "message_body", with: body
      click_button "送信する"
    end

    context "メッセージを入力して送信した場合" do
      let(:body) { "テスト投稿" }

      it "正常にメッセージが投稿される" do
        expect(page).to have_content "テスト投稿"
      end
    end

    context "メッセージを入力せずに送信した場合" do
      let(:body) { nil }

      it "メッセージは投稿されない" do
        expect(page).to have_content "メッセージ内容を入力してください"
      end
    end
  end

  describe "未読/既読" do
    before { create :message, sender: sender, receiver: receiver }

    context "投稿したメッセージが相手に見られていない場合" do
      before do
        sign_in sender
        visit users_messages_path(receiver)
      end

      it "未読が表示される" do
        expect(page).to have_content "未読"
        expect(page).not_to have_content "既読"
      end
    end

    context "投稿したメッセージが相手に見られた場合" do
      before do
        sign_in receiver
        visit users_messages_path(sender)
        sign_out
        sign_in sender
        visit users_messages_path(receiver)
      end

      it "既読が表示される" do
        expect(page).not_to have_content "未読"
        expect(page).to have_content "既読"
      end
    end
  end
end
