require "rails_helper"

RSpec.describe "ProfileEdit", type: :system do
  let(:user) { create :user }

  describe "プロフィール閲覧" do
    context "自分のプロフィールページを訪れた場合" do
      before do
        sign_in user
        visit profile_path(user)
      end

      it "メッセージを見るボタンが表示される" do
        expect(page).to have_content "メッセージを見る"
      end

      it "プロフィール編集リンクが表示される" do
        expect(page).to have_content "プロフィール編集"
      end
    end

    context "自分以外のプロフィールページを訪れた場合" do
      let(:other_user) { create :user }

      before do 
        sign_in user
        visit profile_path(other_user)
      end

      it "メッセージを送るボタンが表示される" do
        expect(page).to have_content "メッセージを送る"
      end

      it "プロフィール編集リンクが表示されない" do
        expect(page).not_to have_content "プロフィール編集"
      end
    end
  end

  describe "プロフィール編集" do
    before do
      sign_in user
      visit edit_users_profile_path
      fill_in "user_display_name", with: display_name
      fill_in "user_introduction", with: introduction
      fill_in "user_url", with: url
      click_button "更新する"
    end

    context "正しく値を入力し送信した場合" do
      let(:display_name) { "テスト太郎" }
      let(:introduction) { "私の名前はテスト太郎です。" }
      let(:url) { "https://example.com" }

      it "プロフィールが更新される" do
        expect(current_path).to eq profile_path(user)
        expect(page).to have_content "テスト太郎"
        expect(page).to have_content "私の名前はテスト太郎です。"
      end
    end

    # FIXME: ブラウザのvalidationに依存して通らずなので
    #        通る方法を見つけ次第実装するようにする
    # context "ユーザー名を入力せずに送信した場合" do
    #   let(:display_name) { nil }
    #   let(:introduction) { "私の名前はテスト太郎です。" }
    #   let(:url) { "https://example.com" }

    #   it "エラーメッセージが表示される" do
    #     expect(current_path).to eq edit_users_profile_path
    #     binding.pry
    #     expect(page).to have_content "ユーザー名を入力してください"
    #   end
    # end

    # context "URLを正しく入力せずに送信した場合" do
    #   let(:display_name) { "テスト太郎" }
    #   let(:introduction) { "私の名前はテスト太郎です。" }
    #   let(:url) { "inval.lid/urlexample" }

    #   it "エラーメッセージが表示される" do
    #     expect(current_path).to eq edit_users_profile_path
    #     expect(page).to have_content "URLは不正な値です"
    #   end
    # end
  end
end
