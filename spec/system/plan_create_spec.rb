require "rails_helper"

RSpec.describe "PlanCreate", type: :system do
  let(:user) { create :user }
  before { sign_in user }

  describe "ヘッダーメニュー" do
    context "プランが作成されていない場合" do
      before do
        visit root_path
        find("#headerNavDropdown").click # ドロップダウン
      end

      it "プラン作成リンクが表示される" do
        expect(page).to have_content "プラン作成"
        expect(page).not_to have_content "プラン編集"
      end
    end

    context "プランが作成されている場合" do
      before do
        create :plan, user: user
        visit root_path
        find("#headerNavDropdown").click # ドロップダウン
      end

      it "プラン編集リンクが表示される" do
        expect(page).not_to have_content "プラン作成"
        expect(page).to have_content "プラン編集"
      end
    end
  end

  describe "作成処理" do
    before do
      visit new_users_plan_path
    end

    context "プラン内容が正しく入力されている場合" do
      before do
        fill_in "plan_name", with: "テストプラン"
        fill_in "plan_description", with: "これはテストで作成したプランです"
        fill_in "plan_courses_attributes_0_name", with: "テストコース"
        fill_in "plan_courses_attributes_0_fee", with: 1000
        fill_in "plan_courses_attributes_0_description", with: "これはテストで作成したコースです"
        click_button "登録する"
      end

      it "正常にプランが作成される" do
        expect(page).to have_current_path plan_path(user.plan)
        expect(page).to have_content "テストプラン"
        expect(page).to have_content "これはテストで作成したプランです"
        expect(page).to have_content "テストコース"
        expect(page).to have_content "1,000円"
        expect(page).to have_content "これはテストで作成したコースです"
      end
    end

    context "プラン内容が正しく入力されていない場合" do
      before do
        fill_in "plan_name", with: nil
        fill_in "plan_description", with: "これはテストで作成したプランです"
        fill_in "plan_courses_attributes_0_name", with: nil
        fill_in "plan_courses_attributes_0_fee", with: 999
        fill_in "plan_courses_attributes_0_description", with: "これはテストで作成したコースです"
        click_button "登録する"
      end

      it "プランは作成されない" do
        expect(page).to have_current_path users_plan_path
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "コース名を入力してください"
        expect(page).to have_content "料金は1000円以上で設定してください"
      end
    end

    context "コースが2件登録されている場合" do
      it "正常にプランが作成される" do
      end
    end

    context "コースが1件も登録されていない場合" do
      it "プランは作成されない" do
      end
    end

    context "コースの追加後に削除を行い登録した場合" do
      it "削除したコースは登録されない" do
      end
    end
  end
end
