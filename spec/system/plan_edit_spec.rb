require "rails_helper"

RSpec.describe "PlanEdit", type: :system do
  let(:plan) { create :plan }

  before do
    sign_in plan.user
    visit edit_users_plan_path
  end

  context "プラン内容が正しく入力されている場合" do
    before do
      fill_in "plan_name", with: "テストプラン"
      fill_in "plan_description", with: "これはテストで更新したプランです"
      fill_in "plan_courses_attributes_0_name", with: "テストコース"
      fill_in "plan_courses_attributes_0_fee", with: 1500
      fill_in "plan_courses_attributes_0_description", with: "これはテストで更新したコースです"
      click_button "更新する"
    end

    it "正常にプランが更新される" do
      expect(page).to have_current_path plan_path(plan)
      expect(page).to have_content "テストプラン"
      expect(page).to have_content "これはテストで更新したプランです"
    end

    it "正常にコースが更新される" do
      expect(page).to have_content "テストコース"
      expect(page).to have_content "1,500円"
      expect(page).to have_content "これはテストで更新したコースです"
    end
  end

  context "コースを削除した場合" do
    before do
      click_link "コースを削除"
      click_button "更新する"
    end

    it "プランは更新されない" do
      expect(page).to have_current_path users_plan_path
      expect(page).to have_content "コースを最低1件は登録してください"
    end
  end

  context "コースを追加した場合" do
    before do
      click_link "コースを追加"
      all("input[placeholder='コース名']")[1].set "テストコース2"
      all("input[placeholder='料金']")[1].set 2000
      all("textarea[placeholder='コース説明']")[1].set "これはテストで追加したコースです"
      click_button "更新する"
    end

    it "正常にプランが更新される" do
      expect(page).to have_current_path plan_path(plan)
    end

    it "追加したプランが表示される" do
      expect(page).to have_content "テストコース2"
      expect(page).to have_content "2,000円"
      expect(page).to have_content "これはテストで追加したコースです"
    end
  end

  context "コースを削除し新たに追加した場合" do
    before do
      click_link "コースを削除"
      click_link "コースを追加"
      find("input[placeholder='コース名']").set "テストコース2"
      find("input[placeholder='料金']").set 2000
      find("textarea[placeholder='コース説明']").set "これはテストで追加したコースです"
      click_button "更新する"
    end

    it "正常にプランが更新される" do
      expect(page).to have_current_path plan_path(plan)
    end

    it "削除したプランは表示されない" do
      expect(page).not_to have_content "Test Course"
      expect(page).not_to have_content "1,000円"
      expect(page).not_to have_content "This is test course"
    end

    it "追加したプランが表示される" do
      expect(page).to have_content "テストコース2"
      expect(page).to have_content "2,000円"
      expect(page).to have_content "これはテストで追加したコースです"
    end
  end
end
