require "rails_helper"

RSpec.describe "Authentication", type: :system do
  describe "ログイン" do
    before do
      Rails.application.env_config["omniauth.auth"] = github_mock(user)
      visit root_path
      click_link "ログイン"
    end

    context "初めてのログインの場合" do
      let(:user) { nil }

      it "ログイン状態になる" do
        expect(page).to have_selector "img.nav-image"
      end
    end
    context "2回目以降のログインの場合" do
      let(:user) { create :user }

      it "ログイン状態になる" do
        expect(page).to have_selector "img.nav-image"
      end
    end
  end

  describe "ログアウト" do
    context "ログアウトした場合" do
      let(:user) { create :user }
      before do
        sign_in user
        find("#headerNavDropdown").click # ドロップダウン
        click_link "ログアウト"
      end

      it "トップ画面に遷移する" do
        expect(page).to have_content "ログイン"
      end
    end
  end
end
