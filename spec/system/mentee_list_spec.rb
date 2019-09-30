require "rails_helper"

RSpec.describe "MenteeList", type: :system do
  let(:mentor) { create :user }
  let(:plan)   { create :plan, user: mentor }
  let(:course) { create :course, plan: plan }

  context "誰もコースに契約をしていない場合" do
    before do
      sign_in mentor
      visit users_mentees_path
    end

    it "menteeは表示されない" do
      expect(page).to have_content "現在契約中のメンティーはいません"
    end
  end

  context "1人が1件のコースに契約をしている場合" do
    let(:mentee) { create :user, display_name: "Test Mentee" }

    before do
      create :contract, course: course, user: mentee
      sign_in mentor
      visit users_mentees_path
    end

    it "1人のmentee表示される" do
      expect(page).to have_content "Test Mentee", count: 1
    end

    it "1種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 1
    end
  end

  context "複数人が1件のコースに契約をしている場合" do
    let(:mentee1) { create :user, display_name: "Test Mentee1" }
    let(:mentee2) { create :user, display_name: "Test Mentee2" }

    before do
      create :contract, course: course, user: mentee1
      create :contract, course: course, user: mentee2
      sign_in mentor
      visit users_mentees_path
    end

    it "複数人のmentee表示される" do
      expect(page).to have_content "Test Mentee1", count: 1
      expect(page).to have_content "Test Mentee2", count: 1
    end

    it "1種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 2
    end
  end

  context "1人が複数件のコースに契約をしている場合" do
    let(:mentee)       { create :user, display_name: "Test Mentee" }
    let(:other_course) { create :course, name: "Other Course", plan: plan }

    before do
      create :contract, course: course, user: mentee
      create :contract, course: other_course, user: mentee
      sign_in mentor
      visit users_mentees_path
    end

    it "1人のmentee表示される" do
      expect(page).to have_content "Test Mentee", count: 1
    end

    it "複数種類のコースが表示される" do
      expect(page).to have_content "Test Course", count: 1
      expect(page).to have_content "Other Course", count: 1
    end
  end

  context "すべてコースの契約が終了している場合" do
    let(:mentee) { create :user, display_name: "Test Mentee" }

    before do
      create :contract, course: course, state: :finished, user: mentee
      sign_in mentor
      visit users_mentees_path
    end

    it "一覧には表示されない" do
      expect(page).to have_content "現在契約中のメンティーはいません"
    end
  end

  context "一部のコースの契約が残っている場合" do
    let(:mentee)       { create :user, display_name: "Test Mentee" }
    let(:alive_course) { create :course, name: "Alive Course", plan: plan }

    before do
      create :contract, course: course, state: :finished, user: mentee
      create :contract, course: alive_course, user: mentee
      sign_in mentor
      visit users_mentees_path
    end

    it "契約中のコースのみ表示される" do
      expect(page).to have_content "Alive Course", count: 1
      expect(page).not_to have_content "Test Course"
    end
  end
end
