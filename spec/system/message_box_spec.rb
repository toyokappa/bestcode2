require "rails_helper"

RSpec.describe "MessageBox", type: :system do
  describe "メッセージ一覧" do
    let(:user_a) { create :user, display_name: "User A" }
    let(:user_b) { create :user, display_name: "User B" }
    let(:user_c) { create :user, display_name: "User C" }

    context "メッセージのやり取りが1件もない場合" do
      before do
        sign_in user_a
        visit users_message_box_path
      end

      it "メッセージがない旨が表示される" do
        expect(page).to have_content "メッセージのやり取りはありません"
      end
    end

    context "メッセージのやり取りが存在する場合" do
      before do
        create :message, sender: user_a, receiver: user_b, body: "this message doesn't display."
        create :message, sender: user_b, receiver: user_a, body: "this message display!"
        create :message, sender: user_c, receiver: user_a, body: "this message display too!"
        sign_in user_a
        visit users_message_box_path
      end

      it "やり取りしているユーザーが表示される" do
        expect(page).to have_content "User B", count: 1
        expect(page).to have_content "User C", count: 1
      end

      it "各ユーザーとの最新のメッセージが表示される" do
        expect(page).to have_content "this message display!", count: 1
        expect(page).to have_content "this message display too!", count: 1
      end

      it "最新のメッセージ以外は表示されない" do
        expect(page).not_to have_content "this message doesn't display."
      end
    end
  end
end
